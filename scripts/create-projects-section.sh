#!/bin/bash

# Paths
REPO_JSON="out/repos.json"
OUTPUT_FILE="src/sections/projects.tex"

# Start writing LaTeX file
echo "\\section{Projects}" > "$OUTPUT_FILE"
echo "\\resumeSubHeadingListStart" >> "$OUTPUT_FILE"

# Read JSON and parse project details
jq -c '.[]' "$REPO_JSON" | while read -r project; do
    NAME=$(echo "$project" | jq -r '.name')
    DESC=$(echo "$project" | jq -r '.description')
    URL=$(echo "$project" | jq -r '.url')
    TOPICS=$(echo "$project" | jq -r '.topics | join(", ")')

    # Use topics directly as tech stack
    TECH=$(echo "$project" | jq -r '.topics | join(", ")')
    TECH=${TECH:-"Unknown"}
    
    # Capitalize first letter of tech stack
    TECH=$(echo "$TECH" | awk '{print toupper(substr($0,1,1)) substr($0,2)}')
    
    # Append project details to LaTeX file
    echo "\\resumeProjectHeading{\\textbf{$NAME} \$|$ \emph{$TECH}}{\\href{$URL}{GitHub}}" >> "$OUTPUT_FILE"
    echo "\\resumeItemListStart" >> "$OUTPUT_FILE"
    echo "\\resumeItem{$DESC}" >> "$OUTPUT_FILE"
    echo "\\resumeItemListEnd" >> "$OUTPUT_FILE"
done

# End LaTeX project section
echo "\\resumeSubHeadingListEnd" >> "$OUTPUT_FILE"

echo "projects.tex generated successfully at $OUTPUT_FILE"
