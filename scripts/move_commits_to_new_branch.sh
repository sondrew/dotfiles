#!/bin/sh
NEW_BRANCH=$(gum input --prompt "Name of new branch: ")
OLDEST_COMMIT=$(gum input --prompt "Oldest commit you want to include: ")
NEWEST_COMMIT=$(gum input --prompt "Newest commit you want to include: ")

CONFIRM="git checkout -b $NEW_BRANCH && git cherry-pick $OLDEST_COMMIT^..$NEWEST_COMMIT"

gum confirm "$CONFIRM" && echo "$CONFIRM"
