#!/usr/bin/env sh
set -euo pipefail

echo 'Running simulation'
Rscript davidshaub_code.R

echo 'Creating davidshaub_artifact.gif'
convert -loop 0 -resize 800x800 10[0-5][0-9].png davidshaub_artifact.gif

# delete intermediate files
rm 10[0-5][0-9].png
