#! /bin/bash

if [ -f .env ]; then
  source .env
else
  echo -e "\e[31m.env file not found. Please create it with a valid GITHUB_TOKEN.\e[0m"
  exit 1
fi

mkdir -p out

curl -L -X POST 'https://api.github.com/graphql' \
-H "Authorization: bearer $GITHUB_TOKEN" \
--data-raw '{"query":"{\n  user(login: \"kmr-ankitt\") {\n pinnedItems(first: 6, types: REPOSITORY) {\n nodes {\n ... on Repository {\n name\n description\n url\n }\n }\n }\n }\n}"}' \
> out/output.json

if [ $? -eq 0 ]; then
  echo -e "\e[32m\nFetch successfully\e[0m"
  echo -e "\e[32m\nOutput:\e[0m"
  bat out/output.json
else
  echo -e "\e[31m\nFailed to fetch data\e[0m"
  exit 1
fi
