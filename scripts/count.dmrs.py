from ete3 import Tree

# Load tree
tree = Tree("/home/abportillo/github_repo/seq-align/mafft/tree.nwk")

# Load name mapping
mapping = {}
with open("/home/abportillo/github_repo/seq-align/mafft/name_mapping.tsv") as f:
    for line in f:
        short, full = line.strip().split("\t")
        mapping[short] = full

# Track DMR-HERVHs in mapping and in tree
dmr_in_mapping = [v for v in mapping.values() if v.startswith("HERVH-dmr::")]
dmr_in_tree = []

# Check which mapped names appear in the tree
for leaf in tree.iter_leaves():
    original_name = leaf.name
    if original_name in mapping:
        full_name = mapping[original_name]
        if full_name.startswith("HERVH-dmr::"):
            dmr_in_tree.append(full_name)

# Compute missing DMR-HERVHs
dmr_missing = set(dmr_in_mapping) - set(dmr_in_tree)

# Print summary
print(f"Total DMR-HERVHs in mapping: {len(dmr_in_mapping)}")
print(f"DMR-HERVHs present in tree: {len(dmr_in_tree)}")
print(f"DMR-HERVHs missing from tree: {len(dmr_missing)}")
