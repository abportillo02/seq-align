#!/bin/bash
#SBATCH --job-name=restore_headers
#SBATCH --output=restore_headers_%j.out
#SBATCH --error=restore_headers_%j.err
#SBATCH --time=01:00:00
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G

# Load your conda/mamba env with Biopython
source ~/.bashrc
conda activate mamba_abner_BC

# ==== INPUT FILES ====
ORIG_FASTA="/home/abportillo/github_repo/seq-align/mafft/real_dmr_hervh_subset_aligned.fasta"
TRIM_FASTA="/home/abportillo/github_repo/seq-align/mafft/trimmed_real_dmr_hervh_subset_aligned.fasta"

# ==== OUTPUT FILES ====
OUT_FASTA="/home/abportillo/github_repo/seq-align/mafft/trimmed_real_dmr_hervh_subset_aligned_renamed.fasta"
OUT_MAP="/home/abportillo/github_repo/seq-align/mafft/trimmed_to_original_mapping.tsv"

# ==== PYTHON SCRIPT ====
python <<'EOF'
from Bio import SeqIO

orig_fasta = "${ORIG_FASTA}"
trimmed_fasta = "${TRIM_FASTA}"
output_fasta = "${OUT_FASTA}"
mapping_tsv = "${OUT_MAP}"

orig_records = list(SeqIO.parse(orig_fasta, "fasta"))
trimmed_records = list(SeqIO.parse(trimmed_fasta, "fasta"))

if len(orig_records) != len(trimmed_records):
    print(f"Sequence count mismatch: {len(orig_records)} original vs {len(trimmed_records)} trimmed")

# create output files
with open(output_fasta, "w") as out_fa, open(mapping_tsv, "w") as out_map:
    out_map.write("trimmed_index\toriginal_header\tnew_header\n")

    for i, (trim_rec, orig_rec) in enumerate(zip(trimmed_records, orig_records), start=1):
        # build a unique name based on original header
        base = orig_rec.id.split("::")[0]
        coord = orig_rec.id.split("::")[-1].replace(":", "_").replace("-", "_")
        new_id = f"{base}_{coord}"

        # replace in trimmed record
        trim_rec.id = new_id
        trim_rec.description = ""

        SeqIO.write(trim_rec, out_fa, "fasta")
        out_map.write(f"{i}\t{orig_rec.id}\t{new_id}\n")

print(f"Finished renaming {len(trimmed_records)} records")
print(f"Output FASTA: {output_fasta}")
print(f"Mapping file: {mapping_tsv}")
EOF
