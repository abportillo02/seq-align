from ete3 import Tree, TreeStyle, TextFace, NodeStyle

# Load tree
tree = Tree("/home/abportillo/github_repo/seq-align/mafft/tree.nwk")

# Load name mapping
mapping = {}
with open("/home/abportillo/github_repo/seq-align/mafft/name_mapping.tsv") as f:
    for line in f:
        short, full = line.strip().split("\t")
        mapping[short] = full

# Rename leaves and color DMR-HERVHs
for leaf in tree.iter_leaves():
    original_name = leaf.name
    if original_name in mapping:
        full_name = mapping[original_name]
        leaf.name = full_name
        if full_name.startswith("HERVH-dmr::"):
            style = NodeStyle()
            style["fgcolor"] = "red"
            style["size"] = 10
            style["shape"] = "sphere"
            leaf.set_style(style)

# Tree style with circular layout
ts = TreeStyle()
ts.show_leaf_name = True
ts.mode = "c"  # Circular layout
ts.title.add_face(TextFace("HERVH Tree with DMRs Highlighted", fsize=20), column=0)

# Save tree as high-resolution PDF
tree.render("/home/abportillo/github_repo/seq-align/mafft/hervh_tree_dmr_colored.pdf", tree_style=ts, w=3000, units="px")
