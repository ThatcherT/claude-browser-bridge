#!/usr/bin/env bash
# PreToolUse hook: ensure browser-bridge daemon is running before any tool call.
# Idempotent — exits 0 immediately if daemon is already up.

DAEMON_NAME="claude-browser-bridge"
DAEMONS_DIR="$HOME/.claude/daemons"
PID_FILE="$DAEMONS_DIR/$DAEMON_NAME.pid"
SOCK_FILE="$DAEMONS_DIR/$DAEMON_NAME.sock"
PLUGIN_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

# Quick check: is the IPC socket reachable?
if [ -S "$SOCK_FILE" ] && [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE" 2>/dev/null)
    if kill -0 "$PID" 2>/dev/null; then
        exit 0
    fi
fi

# Daemon not running — start it
mkdir -p "$DAEMONS_DIR"

DAEMON_IPC_ADDRESS="$SOCK_FILE" nohup node "$PLUGIN_ROOT/dist/daemon.cjs" \
    > "$DAEMONS_DIR/$DAEMON_NAME.stdout.log" \
    2> "$DAEMONS_DIR/$DAEMON_NAME.stderr.log" &
DAEMON_PID=$!
echo "$DAEMON_PID" > "$PID_FILE"

# Wait for IPC socket to appear (up to 5s)
for i in $(seq 1 50); do
    if [ -S "$SOCK_FILE" ]; then
        exit 0
    fi
    sleep 0.1
done

echo "browser-bridge daemon started but IPC socket not ready after 5s" >&2
exit 0
