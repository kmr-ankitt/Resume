#! /bin/bash

NAME=`echo "src/resume.tex" | cut -d'.' -f1`
OUT_DIR="./out"

mkdir -p $OUT_DIR
pdflatex -file-line-error -halt-on-error -output-directory=$OUT_DIR $NAME.tex && xdg-open $OUT_DIR/$(basename $NAME).pdf
