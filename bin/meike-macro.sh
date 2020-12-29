#!/bin/sh

#exiftool -LensModel -LensInfo  -LensMake -LensSerialNumber "$@"
exiftool -P -overwrite_original_in_place -LensInfo-='0mm f/?' -LensInfo='85mm f/2.8' "$@"
exiftool -P -overwrite_original_in_place -LensModel-= -LensModel='Meike MK-85mm f/2.8 Macro' "$@"
exiftool -P -overwrite_original_in_place -LensMake-= -LensMake=MEIKE "$@"
