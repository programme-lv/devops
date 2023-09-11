#!/bin/bash

# get this scripts directory
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

pushd $DIR

# start neovim editor
tmux new-session -d -s my_session -n "nvim" 'bash'
tmux send-keys -t my_session:nvim "nvim ." ENTER
tmux rename-window -t my_session:nvim "nvim"

# start next.js server
tmux new-window -t my_session -n "website" 'bash'
tmux send-keys -t my_session:website "cd website" ENTER
tmux send-keys -t my_session:website "yarn install" ENTER
tmux send-keys -t my_session:website "yarn dev" ENTER

# start website lazygit
tmux new-window -t my_session -n "website-lazygit" 'bash'
tmux send-keys -t my_session:website-lazygit "cd website" ENTER
tmux send-keys -t my_session:website-lazygit "lazygit" ENTER

# start go graphql server
tmux new-window -t my_session -n "backend" 'bash'
tmux send-keys -t my_session:backend "cd backend" ENTER
tmux send-keys -t my_session:backend "go mod tidy" ENTER
tmux send-keys -t my_session:backend "go run ./cmd/server" ENTER

# start backend lazygit
tmux new-window -t my_session -n "backend-lazygit" 'bash'
tmux send-keys -t my_session:backend-lazygit "cd backend" ENTER
tmux send-keys -t my_session:backend-lazygit "lazygit" ENTER

# start database lazygit
tmux new-window -t my_session -n "database-lazygit" 'bash'
tmux send-keys -t my_session:database-lazygit "cd database" ENTER
tmux send-keys -t my_session:database-lazygit "lazygit" ENTER

# start reverse proxy in front
tmux new-window -t my_session -n "r-proxy" 'bash'
tmux send-keys -t my_session:r-proxy "cd devops" ENTER
tmux send-keys -t my_session:r-proxy "sudo caddy run" ENTER

# Attach to the session.
tmux attach -t my_session

popd
