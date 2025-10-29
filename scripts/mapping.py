from Bio import SeqIO
import os

# input_fasta = "/home/abportillo/github_repo/seq-align/mafft/dmr_hervh_aligned.fasta" orignal analysis
input_fasta = "/home/abportillo/github_repo/seq-align/mafft/real_dmr_hervh_subset.fasta"
output_dir = "/home/abportillo/github_repo/seq-align/mafft"
os.makedirs(output_dir, exist_ok=True)

output_fasta = os.path.join(output_dir, "real_dmr_hervh_subset_aligned_int.fasta")
mapping_file = os.path.join(output_dir, "real_name_mapping_subset.tsv")

with open(input_fasta) as infile, open(output_fasta, "w") as outfile, open(mapping_file, "w") as mapfile:
    for i, record in enumerate(SeqIO.parse(infile, "fasta")):
        full_header = record.description  # preserves full header even if truncated in .id
        new_id = f"HERVH{i:04d}"  # Unique PHYLIP-compatible ID
        mapfile.write(f"{new_id}\t{full_header}\n")
        record.id = new_id
        record.description = ""
        SeqIO.write(record, outfile, "fasta")
