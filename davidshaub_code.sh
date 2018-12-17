#!/usr/bin/env sh
set -euo pipefail

echo 'Running simulation'
Rscript davidshaub_code.R

echo 'Creating davidshaub_artifact.gif'
convert -loop 0 -resize 800x800 1*.png davidshaub_artifact.gif

# delete intermediate files
rm 1*.png
