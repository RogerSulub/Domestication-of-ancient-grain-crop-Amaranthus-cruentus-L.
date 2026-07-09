#!/bin/bash -l
#SBATCH -D /scratch/rsulubtu/Analysis/SFS 
#SBATCH -o /scratch/rsulubtu/Analysis/SFS/logs/angsd-stat-%j.txt
#SBATCH -e /scratch/rsulubtu/Analysis/SFS/logs/angsd-stat-%j.err
#SBATCH -t 7-24:00:00
#SBATCH -J angsd-stats
#SBATCH --partition=smp-rh7
#SBATCH --mem 48g
#SBATCH --account=UniKoeln
#SBATCH --mail-user=rsulubtu@uni-koeln.de # receive an email with updates

## Obtain the maximum likelihood estimate of the SFS using the realSFS

/home/rsulubtu/tools/angsd/misc/realSFS Cruentus1.txt_folded.saf.idx -P 24 > Cruentus1.sfs
/home/rsulubtu/tools/angsd/misc/realSFS Cruentus2.txt_folded.saf.idx -P 24 > Cruentus2.sfs
/home/rsulubtu/tools/angsd/misc/realSFS Cruentus3.txt_folded.saf.idx -P 24 > Cruentus3.sfs
/home/rsulubtu/tools/angsd/misc/realSFS Hybridus.txt_folded.saf.idx -P 24 > Hybridus.sfs
/home/rsulubtu/tools/angsd/misc/realSFS Hypochondriacus.txt_folded.saf.idx -P 24 > Hypochondriacus.sfs

## Calculate the thetas for each site

/home/rsulubtu/tools/angsd/misc/realSFS saf2theta Cruentus1.txt_folded.saf.idx -sfs Cruentus1.sfs -outname Cruentus1
/home/rsulubtu/tools/angsd/misc/realSFS saf2theta Cruentus2.txt_folded.saf.idx -sfs Cruentus2.sfs -outname Cruentus2
/home/rsulubtu/tools/angsd/misc/realSFS saf2theta Cruentus3.txt_folded.saf.idx -sfs Cruentus3.sfs -outname Cruentus3
/home/rsulubtu/tools/angsd/misc/realSFS saf2theta Hybridus.txt_folded.saf.idx -sfs Hybridus.sfs -outname Hybridus
/home/rsulubtu/tools/angsd/misc/realSFS saf2theta Hypochondriacus.txt_folded.saf.idx -sfs Hypochondriacus.sfs -outname Hypochondriacus

#Estimate Tajimas D and other statistics

## calculate Tajimas D
/home/rsulubtu/tools/angsd/misc/thetaStat do_stat Cruentus1.thetas.idx
/home/rsulubtu/tools/angsd/misc/thetaStat do_stat Cruentus2.thetas.idx
/home/rsulubtu/tools/angsd/misc/thetaStat do_stat Cruentus3.thetas.idx
/home/rsulubtu/tools/angsd/misc/thetaStat do_stat Hybridus.thetas.idx
/home/rsulubtu/tools/angsd/misc/thetaStat do_stat Hypochondriacus.thetas.idx

## Sliding Window example: ee can easily do a sliding window analysis by adding -win/-step arguments to the last command. thetaStat

#thetaStat do_stat out.thetas.idx -win 50000 -step 10000  -outnames theta.thetasWindow.gz

/home/rsulubtu/tools/angsd/misc/thetaStat do_stat Cruentus1.thetas.idx -win 50000 -step 10000  -outnames Cruentus1.theta.thetasWindow.gz
/home/rsulubtu/tools/angsd/misc/thetaStat do_stat Cruentus2.thetas.idx -win 50000 -step 10000  -outnames Cruentus2.theta.thetasWindow.gz
/home/rsulubtu/tools/angsd/misc/thetaStat do_stat Cruentus3.thetas.idx -win 50000 -step 10000  -outnames Cruentus3.theta.thetasWindow.gz
/home/rsulubtu/tools/angsd/misc/thetaStat do_stat Hybridus.thetas.idx -win 50000 -step 10000  -outnames Hybridus.theta.thetasWindow.gz
/home/rsulubtu/tools/angsd/misc/thetaStat do_stat Hypochondriacus.thetas.idx -win 50000 -step 10000  -outnames Hypochondriacus.theta.thetasWindow.gz

