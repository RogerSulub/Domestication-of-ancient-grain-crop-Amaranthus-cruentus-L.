#!/bin/bash -l
#SBATCH --partition=smp-rh7
#SBATCH -D /scratch/rsulubtu/
#SBATCH -o /scratch/rsulubtu/mapping_ena/mappingLog-%j.txt
#SBATCH -e /scratch/rsulubtu/mapping_ena/mappingLog-%j.err
#SBATCH -t 24:00:00
#SBATCH -J Mapping_ena_data
#SBATCH --nodes=1
#SBATCH --ntasks 8
#SBATCH --mem 42gb
#SBATCH --mail-type=ALL
#SBATCH --account=UniKoeln
#SBATCH --mail-user=rsulubtu@uni-koeln.de

module load openjdk/1.8.0_202
module use /opt/rrzk/modules/experimental
module load bwamem2/2.2.1
module load samtools/1.13

REFERENCE=/home/rsulubtu/reference/Amaranthus_cruentus.softmasked.fa

bwa-mem2 index $REFERENCE

PROVIDER=NOVOGENE

OUTPUTPATH=ena_bam_files
FASTQPATH=/scratch/rsulubtu/ENA_download2
#mkdir -p $OUTPUTPATH
#mkdir -p $OUTPUTPATH/metrics/

#for SAMPLES in /scratch/rsulubtu/ENA_download2/*
IFS=$'\n' SAMPLES=($(cat /scratch/rsulubtu/ENA_download2/accession.txt))

for ((i=0;i<${#SAMPLES[@]};++i));

do
 	echo Maping reads of ${SAMPLES[i]}
SORTED_NAME=${OUTPUTPATH}/${SAMPLES[i]}.bam
echo $SORTED_NAME

bwa-mem2 mem -t 8 -R '@RG\tID:'${SAMPLES[i]}'\tSM:'${SAMPLES[i]}'\tCN:'${PROVIDER}'\tPL:illumina' $REFERENCE ${FASTQPATH}/${SAMPLES[i]}_1.fastq.gz ${FASTQPATH}/${SAMPLES[i]}_2.fastq.gz | samtools sort -O bam -o ${SORTED_NAME}

#echo mark duplicates
DEDUP_NAME=${OUTPUTPATH}/${SAMPLES[i]}.final.bam
METRICS_FILE=${OUTPUTPATH}/metrics/${SAMPLES[i]}.txt
java -Xmx4g -jar /home/rsulubtu/tools/picard.jar MarkDuplicates INPUT=$SORTED_NAME OUTPUT=$DEDUP_NAME METRICS_FILE=$METRICS_FILE
samtools index $DEDUP_NAME

echo calculate samtools flagstat
samtools flagstat ${DEDUP_NAME} > ${OUTPUTPATH}/metrics/${SAMPLES[i]}.flagstat

echo removing sorted bam
rm $SORTED_NAME


done
