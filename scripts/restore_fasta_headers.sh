#!/bin/bash
#SBATCH --job-name=restore_headers
#SBATCH --output=restore_headers_%j.out
#SBATCH --error=restore_headers_%j.err
#SBATCH --time=01:00:00
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G

# Load conda env
source ~/.bashrc
conda activate mamba_abner_BC

# ==== INPUT FILES ====
export ORIG_FASTA="/home/abportillo/github_repo/seq-align/mafft/real_dmr_hervh_subset_aligned.fasta"
export TRIM_FASTA="/home/abportillo/github_repo/seq-align/mafft/trimmed_real_dmr_hervh_subset_aligned.fasta"

# ==== OUTPUT FILES ====
export OUT_FASTA="/home/abportillo/github_repo/seq-align/mafft/trimmed_real_dmr_hervh_subset_aligned_renamed.fasta"
export OUT_MAP="/home/abportillo/github_repo/seq-align/mafft/trimmed_to_original_mapping.tsv"

python <<'EOF'
import os
from Bio import SeqIO

orig_fasta = os.environ["ORIG_FASTA"]
trimmed_fasta = os.environ["TRIM_FASTA"]
output_fasta = os.environ["OUT_FASTA"]
mapping_tsv = os.environ["OUT_MAP"]

orig_records = list(SeqIO.parse(orig_fasta, "fasta"))
trimmed_records = list(SeqIO.parse(trimmed_fasta, "fasta"))

print(f"Original: {len(orig_records)} sequences")
print(f"Trimmed: {len(trimmed_records)} sequences")

if len(trimmed_records) > len(orig_records):
    raise ValueError("Trimmed FASTA has more sequences than the original, which should not happen.")

# Prepare output
with open(output_fasta, "w") as out_fa, open(mapping_tsv, "w") as out_map:
    out_map.write("index\ttrimmed_header\toriginal_header\tnew_id\n")

    # Map trimmed sequences to originals by order, skipping removed ones
    orig_index = 0
    for i, trim_rec in enumerate(trimmed_records, start=1):
        while orig_index < len(orig_records) and orig_records[orig_index].seq.count("-") == len(orig_records[orig_index].seq):
            orig_index += 1  # Skip all-gap sequences in original if any

        if orig_index >= len(orig_records):
            break

        orig_rec = orig_records[orig_index]
        orig_index += 1

        base = orig_rec.id.split("::")[0]
        coord = orig_rec.id.split("::")[-1].replace(":", "_").replace("-", "_")
        new_id = f"{base}_{coord}"

        trim_rec.id = new_id
        trim_rec.description = ""

        SeqIO.write(trim_rec, out_fa, "fasta")
        out_map.write(f"{i}\t{trim_rec.id}\t{orig_rec.id}\t{new_id}\n")

print(f"Restored headers for {len(trimmed_records)} trimmed sequences.")
print(f"Output FASTA: {output_fasta}")
print(f"Mapping file: {mapping_tsv}")
EOF
