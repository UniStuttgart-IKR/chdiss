# gs \
#  -sOutputFile=mainbw.pdf \
#  -sDEVICE=pdfwrite \
#  -sColorConversionStrategy=Gray \
#  -dProcessColorModel=/DeviceGray \
#  -dCompatibilityLevel=1.4 \
#  -dNOPAUSE \
#  -dBATCH \
#  main.pdf

# convert -colorspace GRAY main.pdf mainbw.pdf

gs -sOutputFile=mainbw.pdf -sDEVICE=pdfwrite -sColorConversionStrategy=Gray -dProcessColorModel=/DeviceGray -dCompatibilityLevel=1.4 -dNOPAUSE -dBATCH main.pdf
