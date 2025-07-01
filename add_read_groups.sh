#!/bin/bash

module load gcc java

# Define input and output directories
input_dir=$1
output_dir=$2

# Create output directory if it doesn't exist
mkdir -p "$output_dir"

# Loop through all BAM files in the input directory
for bam_file in "$input_dir"/*.bam; do
    # Extract the base name of the BAM file
    base_name=$(basename "$bam_file" .bam)
    
    # Define the output file path
    output_bam="$output_dir/${base_name}_RG.bam"

    # Check if the output file already exists
    if [ -f "$output_bam" ]; then
        echo "File $output_bam already exists. Skipping..."
        continue
    fi
    
    # Set the @RG parameters dynamically
    RGLB="lib_${base_name}"  # Library name, e.g., based on the file name
    RGPL="illumina"          # Platform, set to 'illumina' unless you use a different sequencing technology
    RGPU="unit_${base_name}" # Unique identifier for the sequencing unit
    RGSM="${base_name}"      # Sample name, set based on the BAM file name

    # Run Picard AddOrReplaceReadGroups
    java -jar /n/data1/hms/dbmi/gulhan/lab/software/alon/software/picard.jar AddOrReplaceReadGroups \
        I="$bam_file" \
        O="$output_dir/${base_name}_RG.bam" \
        RGLB="$RGLB" \
        RGPL="$RGPL" \
        RGPU="$RGPU" \
        RGSM="$RGSM"
done

echo "Finished processing all BAM files."