#!/bin/bash
#SBATCH --job-name=restore_headers
#SBATCH --output=restore_headers_%j.out
#SBATCH --error=restore_headers_%j.err
#SBATCH --time=01:00:00
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G

# Load conda environment
source ~/.bashrc
conda activate mamba_abner_BC

# ==== INPUT FILES ====
ORIG_FASTA="/home/abportillo/github_repo/seq-align/mafft/real_dmr_hervh_subset_aligned.fasta"
TRIM_FASTA="/home/abportillo/github_repo/seq-align/mafft/trimmed_real_dmr_hervh_subset_aligned.fasta"

# ==== OUTPUT FILES ====
OUT_FASTA="/home/abportillo/github_repo/seq-align/mafft/trimmed_real_dmr_hervh_subset_aligned_renamed.fasta"
OUT_MAP="/home/abportillo/github_repo/seq-align/mafft/trimmed_to_original_mapping.tsv"

# ==== PYTHON SCRIPT ====
python <<EOF
from Bio import SeqIO

orig_fasta = "${ORIG_FASTA}"
trimmed_fasta = "${TRIM_FASTA}"
output_fasta = "${OUT_FASTA}"
mapping_tsv = "${OUT_MAP}"

orig_records = list(SeqIO.parse(orig_fasta, "fasta"))
trimmed_records = list(SeqIO.parse(trimmed_fasta, "fasta"))

print(f"Original sequences: {len(orig_records)}")
print(f"Trimmed sequences: {len(trimmed_records)}")

# Handle cases where trimal removed all-gap sequences
min_len = min(len(orig_records), len(trimmed_records))

with open(output_fasta, "w") as out_fa, open(mapping_tsv, "w") as out_map:
    out_map.write("unique_id\toriginal_header\n")

    for i, (trim_rec, orig_rec) in enumerate(zip(trimmed_records[:min_len], orig_records[:min_len]), start=1):
        new_id = f"seq{i:04d}"
        trim_rec.id = new_id
        trim_rec.description = ""
        SeqIO.write(trim_rec, out_fa, "fasta")
        out_map.write(f"{new_id}\t{orig_rec.id}\n")

print(f"Finished renaming {min_len} records")
print(f"Output FASTA: {output_fasta}")
print(f"Mapping file: {mapping_tsv}")
EOF
