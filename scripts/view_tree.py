from ete3 import Tree, TreeStyle, TextFace

tree = Tree("/home/abportillo/github_repo/seq-align/mafft/trimmed_dmr_hervh_aligned.phy_phyml_tree.txt")

ts = TreeStyle()
ts.show_leaf_name = True
ts.title.add_face(TextFace("HERVH DMR Tree", fsize=20), column=0)

# Save tree as PNG image
tree.render("hervh_dmr_tree.png", tree_style=ts, w=800, units="px")
