#!/bin/zsh

# Check for correct number of arguments
if (( $# != 2 )); then
    echo "Usage: $0 <branchOrTag1> <branchOrTag2>"
    exit 1
fi

# Assign arguments to variables
branchOrTag1=$1
branchOrTag2=$2

# Get commit messages from both branches/tags
commitMessages1=("${(@f)$(git log $branchOrTag1 --pretty=format:"%s")}")
commitMessages2=("${(@f)$(git log $branchOrTag2 --pretty=format:"%s")}")

# Loop through commit messages from branchOrTag1 and check against branchOrTag2
for msg in $commitMessages1; do
    if (( ${commitMessages2[(Ie)$msg]} == 0 )); then
        echo $msg
    fi
done
