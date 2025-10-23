from Bio import SeqIO
import os

input_fasta = "/home/abportillo/github_repo/seq-align/mafft/trimmed_dmr_hervh_aligned.fasta"
output_dir = "/home/abportillo/github_repo/seq-align/mafft"
os.makedirs(output_dir, exist_ok=True)

output_fasta = os.path.join(output_dir, "renamed.fasta")
mapping_file = os.path.join(output_dir, "name_mapping.tsv")

with open(input_fasta) as infile, open(output_fasta, "w") as outfile, open(mapping_file, "w") as mapfile:
    for i, record in enumerate(SeqIO.parse(infile, "fasta")):
        new_id = f"HERVH{i:04d}"  # Unique PHYLIP-compatible ID
        mapfile.write(f"{new_id}\t{record.id}\n")
        record.id = new_id
        record.description = ""
        SeqIO.write(record, outfile, "fasta")
