#!/bin/bash
outdir="$HOME/Dev/kmrankit/public"

read -p "Do you want to push this to github(y/n): " answer

if [[ $answer != "y" ]]; then
    echo -e "\e[31mExiting without pushing to GitHub.\e[0m"
    exit 0
fi

cp ./out/myresume.pdf "$outdir"
echo -e "\e[32mResume placed.\e[0m"
cd ~/Dev/kmrankit/public

echo -e "\e[33mPushing to GitHub...\e[0m"
echo -e "\e[33mPushing to GitHub...\e[0m"
git add -- myresume.pdf
git commit -m "feat: udpate resume"
git push origin main

echo -e "\e[32mResume published successfully.\e[0m"
