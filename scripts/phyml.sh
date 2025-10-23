#!/bin/bash
#SBATCH --job-name=phyml_dmr_hervh
#SBATCH --output=phyml_dmr_hervh.out
#SBATCH --error=phyml_dmr_hervh.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=abportillo@coh.org
#SBATCH -n 4
#SBATCH -p all
#SBATCH --mem=4G
#SBATCH --time=12:00:00

source ~/.bashrc
conda activate mamba_abner_BC

phyml -i trimmed_dmr_hervh_aligned.phy -d nt 