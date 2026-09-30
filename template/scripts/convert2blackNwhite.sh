#!/bin/bash

# Default input and output paths
INPUT="${1:-main.pdf}"
OUTPUT="${2:-mainbw.pdf}"

# Check if the input file exists
if [ ! -f "$INPUT" ]; then
    echo "Error: Input file '$INPUT' not found."
    echo "Usage: $0 [input.pdf] [output_bw.pdf]"
    exit 1
fi

echo "Converting '$INPUT' to grayscale: '$OUTPUT'..."

# Run Ghostscript conversion quietly
gs -q \
   -sDEVICE=pdfwrite \
   -sColorConversionStrategy=Gray \
   -dProcessColorModel=/DeviceGray \
   -dCompatibilityLevel=1.4 \
   -dNOPAUSE \
   -dBATCH \
   -sOutputFile="$OUTPUT" \
   "$INPUT" > /dev/null

if [ $? -eq 0 ]; then
    echo "Success! Grayscale PDF saved as '$OUTPUT'."
else
    echo "Error: Conversion failed."
    exit 1
fi
