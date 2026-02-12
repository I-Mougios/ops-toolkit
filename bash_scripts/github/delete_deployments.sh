#!/bin/bash

# 1. Variables and Defaults
OWNER="I-Mougios"
REPO="pymaestro"

# 2. Logic: Decide which IDs to delete
if [ "$#" -gt 0 ]; then
  # Use IDs provided as arguments
  IDS_TO_DELETE=("$@")
  echo "Targeting specific IDs: ${IDS_TO_DELETE[*]}"
else
  echo "No IDs provided. Fetching all deployment IDs for $OWNER/$REPO..."
  IDS_TO_DELETE=($(gh api "repos/$OWNER/$REPO/deployments" --jq '.[].id'))
fi

# 3. Check if we actually have anything to delete
if [ ${#IDS_TO_DELETE[@]} -eq 0 ]; then
  echo "No deployments found to delete."
  exit 0
fi

# 4. Safety Confirmation
read -p "Are you sure you want to delete ${#IDS_TO_DELETE[@]} deployment(s)? (y/n): " CONFIRM
if [[ $CONFIRM != "y" ]]; then
  echo "Aborting."
  exit 1
fi

# 5. The Deletion Loop
for id in "${IDS_TO_DELETE[@]}"; do
  echo "Deleting deployment ID: $id..."

  gh api --method DELETE "repos/$OWNER/$REPO/deployments/$id"

  if [ $? -eq 0 ]; then
    echo "Successfully deleted $id"
  else
    echo "Failed to delete $id (It might be an active environment)"
  fi
done

echo "Cleanup complete."