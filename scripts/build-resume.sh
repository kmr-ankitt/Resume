#! /bin/bash

NAME="resume"

echo -e "\e[34mMaking scripts executable...\e[0m"
chmod +x ./scripts/fetch-repos.sh
chmod +x ./scripts/create-projects-section.sh

echo -e "\e[32mRunning fetch-repos.sh...\e[0m"
bash ./scripts/fetch-repos.sh
if [ $? -ne 0 ]; then
  echo -e "\e[31mError: fetch-repos.sh failed\e[0m" >&2
  exit 1
fi

echo -e "\e[32mRunning create-projects-section.sh...\e[0m"
bash ./scripts/create-projects-section.sh
if [ $? -ne 0 ]; then
  echo -e "\e[31mError: create-projects-section.sh failed\e[0m" >&2
  exit 1
fi

echo -e "\e[32mScripts executed successfully.\e[0m"

cd src
OUT_DIR="../out"

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
