#!/usr/bin/env sh
set -eu

/setup-ssh.sh

rm -rf .git/hooks/pre-push

export GIT_SSH_COMMAND="ssh -v -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no -l $INPUT_SSH_USERNAME"
git config --global filter.lfs.smudge "git-lfs smudge --skip -- %f"
git config --global filter.lfs.process "git-lfs filter-process --skip"
git remote add mirror "$INPUT_TARGET_REPO_URL"
git push --tags --force --no-verify --prune mirror
