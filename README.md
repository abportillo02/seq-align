# seq-align

# Get merged bed and concatenateed
# Get Fasta 
# ran mapping to truncate headers and but be able to map back at the end
# run MAFFT on bash (computer not slurm doesnt work for some reason)
<!-- bash mafft_alignment.sh 
nthread = 16
nthreadpair = 16
nthreadtb = 16
ppenalty_ex = 0
stacksize: 8192 kb
generating a scoring matrix for nucleotide (dist=200) ... done
Gap Penalty = -1.53, +0.00, +0.00



Making a distance matrix ..
    1 / 100 (thread    0)
done.

Constructing a UPGMA tree (efffree=0) ... 
   90 / 100
done.

Progressive alignment 1/2... 
STEP    99 / 99 (thread   13) f
done.

Making a distance matrix from msa.. 
    0 / 100 (thread    1)
done.

Constructing a UPGMA tree (efffree=1) ... 
   90 / 100
done.

Progressive alignment 2/2... 
STEP    99 / 99 (thread   14) f
done.

disttbfast (nuc) Version 7.525
alg=A, model=DNA200 (2), 1.53 (4.59), -0.00 (-0.00), noshift, amax=0.0
16 thread(s)

distout=h
generating a scoring matrix for nucleotide (dist=200) ... done
    0 / 100 (thread    1)dndpre (nuc) Version 7.525
alg=X, model=DNA200 (2), 1.53 (4.59), 0.37 (1.11), noshift, amax=0.0
16 thread(s)

minimumweight = 0.000010
autosubalignment = 0.000000
nthread = 8
randomseed = 0
blosum 62 / kimura 200
poffset = 0
niter = 2
sueff_global = 0.100000
nadd = 2
generating a scoring matrix for nucleotide (dist=200) ... done

   90 / 100
Segment   1/  1    1-12284
002-0196-1 (thread    7) worse         
Reached 2
done
dvtditr (nuc) Version 7.525
alg=A, model=DNA200 (2), 1.53 (4.59), -0.00 (-0.00), noshift, amax=0.0
8 thread(s)


Strategy:
 FFT-NS-i (Standard)
 Iterative refinement method (max. 2 iterations)

If unsure which option to use, try 'mafft --auto input > output'.
For more information, see 'mafft --help', 'mafft --man' and the mafft page.

The default gap scoring scheme has been changed in version 7.110 (2013 Oct).
It tends to insert more gaps into gap-rich regions than previous versions.
To disable this change, add the --leavegappyregion option. -->

# trimming using trimal 
# seqmagick convert fasta to .phy file 
# phyml to get phy file (text files were empty)
# So decided to do FastTree -nt trimmed_dmr_hervh_aligned.phy > tree.nwk
# view tree.py to map back names and visualize
