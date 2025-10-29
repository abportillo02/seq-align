from Bio import SeqIO
import pandas as pd
import os

# Input files
trimmed_fasta = "/home/abportillo/github_repo/seq-align/mafft/trimmed_real_dmr_hervh_subset_aligned.fasta"
mapping_stage1 = "/home/abportillo/github_repo/seq-align/mafft/real_name_mapping_subset.tsv"
output_fasta = "/home/abportillo/github_repo/seq-align/mafft/trimmed_real_dmr_hervh_subset_aligned_unique.fasta"
output_mapping = "/home/abportillo/github_repo/seq-align/mafft/trimmed_real_name_mapping_subset.tsv"

# Load stage 1 mapping (HERVHxxxx → original header)
map1 = pd.read_csv(mapping_stage1, sep="\t", header=None, names=["old_id", "original_header"])
map1_dict = dict(zip(map1["old_id"], map1["original_header"]))

# Process trimmed FASTA
records = list(SeqIO.parse(trimmed_fasta, "fasta"))

with open(output_fasta, "w") as out_fasta, open(output_mapping, "w") as out_map:
    out_map.write("unique_id\told_id\toriginal_header\n")

    for i, record in enumerate(records, start=1):
        new_id = f"seq{i:04d}"           # new unique ID
        old_id = record.id.strip()       # old ID from the trimmed fasta (HERVH000x)
        original_header = map1_dict.get(old_id, "NA")

        # Write FASTA with new unique ID
        record.id = new_id
        record.description = ""
        SeqIO.write(record, out_fasta, "fasta")

        # Write mapping file with 3 columns
        out_map.write(f"{new_id}\t{old_id}\t{original_header}\n")

print(f"Done! Output FASTA: {output_fasta}")
print(f"Mapping file: {output_mapping}")








