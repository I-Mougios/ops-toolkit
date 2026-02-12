#!/bin/bash

# 1. Check for argument count (must be 0 or 2)
if [ "$#" -ne 0 ] && [ "$#" -ne 2 ]; then
  echo "Error: Invalid number of arguments."
  echo "Usage: $0 [owner] [repo] (or 0 arguments for defaults)"
  exit 1
fi

# 2. Assign variables with defaults
OWNER=${1:-I-Mougios}
REPO=${2:-pymaestro}

# Using a clean header
echo "----------------------------------------"
echo " Target: $OWNER/$REPO"
echo "----------------------------------------"

# 3. Find deployments ids and dates
RESULT=$(gh api "repos/$OWNER/$REPO/deployments" --jq '.[] | "ID: \(.id) | Date: \(.created_at)"')

if [ -z "$RESULT" ]; then
  echo " No deployments found for this repository."
else
  echo "$RESULT"
fi
