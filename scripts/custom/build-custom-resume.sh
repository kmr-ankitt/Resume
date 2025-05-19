#! /bin/bash

NAME="webresume"

echo -e "\e[34mMaking scripts executable...\e[0m"
chmod +x ./scripts/publish-custom-resume.sh

cd src/custom
OUT_DIR="../../out"

echo -e "\e[34mCreating output directory...\e[0m"
mkdir -p $OUT_DIR

echo -e "\e[34mCompiling LaTeX file...\e[0m"
pdflatex -file-line-error -halt-on-error -output-directory=$OUT_DIR ./$NAME.tex
if [ $? -ne 0 ]; then
  echo -e "\e[31mError: Failed to compile LaTeX file\e[0m" >&2
  exit 1
fi

echo -e "\e[32mCompilation successful. Opening PDF...\e[0m"
xdg-open $OUT_DIR/$NAME.pdf
if [ $? -ne 0 ]; then
  echo -e "\e[31mError: Failed to open PDF file\e[0m" >&2
  exit 1
fi

echo -e "\e[32mPDF opened successfully.\e[0m"

cd -
bash ./scripts/custom/publish-custom-resume.sh
if [ $? -ne 0 ]; then
  echo -e "\e[31mError: Failed to publish resume\e[0m" >&2
  exit 1
fi