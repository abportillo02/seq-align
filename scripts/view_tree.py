from ete3 import Tree, TreeStyle, TextFace

# Load tree
tree = Tree("/home/abportillo/github_repo/seq-align/mafft/tree.nwk")

# Load name mapping
mapping = {}
with open("/home/abportillo/github_repo/seq-align/mafft/name_mapping.tsv") as f:
    for line in f:
        short, full = line.strip().split("\t")
        mapping[short] = full

# Rename leaves using mapping
for leaf in tree.iter_leaves():
    if leaf.name in mapping:
        leaf.name = mapping[leaf.name]

# Tree style
ts = TreeStyle()
ts.show_leaf_name = True
ts.title.add_face(TextFace("HERVH Tree with Original Names", fsize=20), column=0)

# Save tree image
tree.render("/home/abportillo/github_repo/seq-align/mafft/hervh_tree_renamed.png", tree_style=ts, w=800, units="px")