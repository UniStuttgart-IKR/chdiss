#!/bin/bash

# Define input and output paths
INPUT="./typstfiles/main.pdf"
OUTPUT="./typstfiles/mainbw.pdf"

# Check if the input file exists
if [ ! -f "$INPUT" ]; then
    echo "Error: Input file '$INPUT' not found."
    exit 1
fi

echo "Converting '$INPUT' to black and white..."

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

# Check if the command was successful
if [ $? -eq 0 ]; then
    echo "Success! Grayscale PDF saved as '$OUTPUT'."
else
    echo "Error: Conversion failed."
    exit 1
fi
