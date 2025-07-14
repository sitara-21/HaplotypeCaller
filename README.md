# HaplotypeCaller
Pipeline to run HaplotypeCaller Mutation Caller
This pipeline can be run on 02 (Harvard's HPC cluster) to call germline mutations on samples.

This pipeline can be run by executing the python script like below:
```
python3 ./HaplotypeCaller_read.py \
-csv ${tumor_normal_csv} \
-normal ${output_path}/.PreProcessing \
-out ${output_path} \
-reference $fasta \
-reference_name mm10 \
-p medium \
-t 1-00:00:00 \
-ct 700 -cm 4000 \
--mem_per_cpu 3G \
-stall 60 \
-r1 1 -r2 1000
```

### Add Read Groups (@RG) Tag
If your alignment script does not automatically add @RG tags to your BAMs, you can run the ```./add_read_groups.sh``` in an interactive session with memory and time parameters depending on the depth of samples. This script will add @RG tag to your sample's BAM file(s) which is required by the HaplotypeCaller script to run.
