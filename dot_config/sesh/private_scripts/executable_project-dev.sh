#!/usr/bin/env bash
# Bootstrap a tmux workflow for a generic web application.

set -euo pipefail

# Allow overrides via environment variables (for sesh or manual use).
SESSION_NAME="${SESSION_NAME:-webapp}"
PROJECT_DIR="${PROJECT_DIR:-$HOME/projects/web-app}"

if ! command -v tmux >/dev/null 2>&1; then
    echo "tmux is required but was not found in PATH" >&2
    exit 1
fi

if [ ! -d "$PROJECT_DIR" ]; then
    echo "Project directory not found: $PROJECT_DIR" >&2
    exit 1
fi

create_window() {
    local index="$1"
    local name="$2"
    local dir="${3:-$PROJECT_DIR}"
    local cmd="${4:-}"

    if [ "$index" -eq 1 ]; then
        tmux rename-window -t "${SESSION_NAME}:1" "$name"
        tmux send-keys -t "${SESSION_NAME}:1" "clear" C-m
    else
        tmux new-window -t "${SESSION_NAME}:${index}" -n "$name" -c "$dir"
    fi

    if [ -n "$cmd" ]; then
        tmux send-keys -t "${SESSION_NAME}:${index}" "$cmd" C-m
    fi
}

if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    tmux new-session -d -s "$SESSION_NAME" -c "$PROJECT_DIR" -n "editor"

    create_window 1 "editor" "$PROJECT_DIR"
    create_window 2 "server" "$PROJECT_DIR" "${START_SERVER_CMD:-# run: npm run dev}"
    create_window 3 "tests" "$PROJECT_DIR" "${TEST_CMD:-# run: npm test}"

    create_window 4 "logs" "$PROJECT_DIR"
    tmux split-window -t "${SESSION_NAME}:4" -h -c "$PROJECT_DIR"
    tmux send-keys -t "${SESSION_NAME}:4.1" "${LOG_CMD:-# tail -f logs/app.log}" C-m
    tmux send-keys -t "${SESSION_NAME}:4.2" "${MONITOR_CMD:-# htop}" C-m

    create_window 5 "db" "$PROJECT_DIR" "${DB_CMD:-# connect to your database client}"
    create_window 6 "git" "$PROJECT_DIR" "git status"
fi

tmux attach-session -t "$SESSION_NAME"
