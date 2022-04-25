#!/usr/bin/env sh
set -eu

/setup-ssh.sh

export GIT_SSH_COMMAND="ssh -v -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no -l $INPUT_SSH_USERNAME"
git remote add mirror "$INPUT_TARGET_REPO_URL"
git config lfs.allowincompletepush true
git lfs push --all mirror "refs/remotes/origin/*:refs/heads/*"
git push --tags --force --prune mirror "refs/remotes/origin/*:refs/heads/*"
