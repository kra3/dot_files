#!/usr/bin/env bash
# Snoopy Development Session
# Place this in ~/.config/sesh/scripts/ or call directly

SESSION_NAME="snoopy"
PROJECT_DIR="$HOME/src/poi.org/snoopy"

# Create session if it doesn't exist
if ! tmux has-session -t=$SESSION_NAME 2>/dev/null; then
    # Create new session in detached mode
    tmux new-session -d -s $SESSION_NAME -c $PROJECT_DIR -n "editor"

    # Window 1: Editor (vim/nvim/code)
    tmux send-keys -t $SESSION_NAME:1 "clear" C-m

    # Window 2: API Server
    tmux new-window -t $SESSION_NAME:2 -n "api" -c "$PROJECT_DIR"
    tmux send-keys -t $SESSION_NAME:2 "# Run: gw runPlay" C-m

    # Window 3: Build/Test
    tmux new-window -t $SESSION_NAME:3 -n "build" -c "$PROJECT_DIR"
    tmux send-keys -t $SESSION_NAME:3 "# Run: gw test or gw uB" C-m

    # Window 4: Logs & Monitoring
    tmux new-window -t $SESSION_NAME:4 -n "logs" -c "$PROJECT_DIR"
    tmux split-window -t $SESSION_NAME:4 -h -c "$PROJECT_DIR"
    tmux send-keys -t $SESSION_NAME:4.1 "# Kafka logs / Docker logs" C-m
    tmux send-keys -t $SESSION_NAME:4.2 "# Application logs" C-m

    # Window 5: DB/Tools
    tmux new-window -t $SESSION_NAME:5 -n "db" -c "$PROJECT_DIR"
    tmux send-keys -t $SESSION_NAME:5 "# PostgreSQL client or other tools" C-m

    # Window 6: Git
    tmux new-window -t $SESSION_NAME:6 -n "git" -c "$PROJECT_DIR"
    tmux send-keys -t $SESSION_NAME:6 "git status" C-m

    # Select first window
    tmux select-window -t $SESSION_NAME:1
fi

# Attach to session
tmux attach-session -t $SESSION_NAME
