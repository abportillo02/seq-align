from ete3 import Tree, TreeStyle

# Load the tree from your PhyML output
tree = Tree("/home/abportillo/github_repo/seq-align/mafft/trimmed_dmr_hervh_aligned.phy_phyml_tree.txt")

# Customize tree style
ts = TreeStyle()
ts.show_leaf_name = True
ts.title.add_face(TextFace("HERVH DMR Tree", fsize=20), column=0)

# Show the tree
tree.show(tree_style=ts)
