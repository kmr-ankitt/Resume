#! /bin/bash

OWNER="kmr-ankitt"
if [ -f .env ]; then
  source .env
else
  echo -e "\e[31m.env file not found. Please create it with a valid GITHUB_TOKEN.\e[0m"
  exit 1
fi

mkdir -p out
rm -rf out/repo-topics.json

function fetch-pinned-repos(){
  echo -e "\e[34m"
  echo "Fetching pinned repositories..."
  echo -e "\e[0m"

  curl -L -X POST 'https://api.github.com/graphql' \
  -H "Authorization: bearer $GITHUB_TOKEN" \
  --data-raw "{\"query\":\"{\n  user(login: \\\"$OWNER\\\") {\n pinnedItems(first: 6, types: REPOSITORY) {\n nodes {\n ... on Repository {\n name\n description\n url\n }\n }\n }\n }\n}\"}" \
  > out/pinned-repos.json
}

function fetch_topics(){
  REPO=$1
  curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/$OWNER/$REPO/topics \
  | jq -c '.names | {name: "'$REPO'", topics: .}' >> out/repo-topics.json
}

function extract_pinned_repos(){
  jq -r '.data.user.pinnedItems.nodes | map({name, description, url})' out/pinned-repos.json > out/extracted-pinned-repos.json
}

function merge_json(){
  jq -s 'map(.[]) | group_by(.name) | map(reduce .[] as $item ({}; . + $item))' out/extracted-pinned-repos.json out/repo-topics.json > out/repos.json
}

function response(){
  fetch-pinned-repos

  echo -e "\e[34m"
  echo "Fetching topics for pinned repositories..."
  echo -e "\e[0m"
  echo "[" > out/repo-topics.json
  jq -r '.data.user.pinnedItems.nodes[].name' out/pinned-repos.json | while read -r repo; do
    fetch_topics "$repo"
    echo "," >> out/repo-topics.json
  done
  sed -i '$ s/,$//' out/repo-topics.json
  echo "]" >> out/repo-topics.json

  extract_pinned_repos
  merge_json
}

response

if [ $? -eq 0 ]; then
  echo -e "\e[32m\nFetch successfully\e[0m"
  echo -e "\e[32m\nOutput:\e[0m"
  cat out/repos.json
  rm -rf out/pinned-repos.json
  rm -rf out/repo-topics.json
  rm -rf out/extracted-pinned-repos.json
else
  echo -e "\e[31m\nFailed to fetch data\e[0m"
  exit 1
fi
