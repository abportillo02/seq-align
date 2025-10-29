#!/bin/bash
#SBATCH --job-name=FastTree
#SBATCH --output=/home/abportillo/github_repo/seq-align/mafft/FastTree.out
#SBATCH --error=/home/abportillo/github_repo/seq-align/mafft/FastTree.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=abportillo@coh.org
#SBATCH -n 16
#SBATCH -N 1
#SBATCH -p all
#SBATCH --mem=50G
#SBATCH --time=12:00:00

source /home/abportillo/.bashrc
conda activate /home/abportillo/.conda/envs/mamba_abner_BC

FastTree -nt /home/abportillo/github_repo/seq-align/mafft/real_dmr_hervh.phy > /home/abportillo/github_repo/seq-align/mafft/real_dmr_hervh_tree_subset_200.nwk
