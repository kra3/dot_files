#!/usr/bin/env bash
# Test and verify tmux configuration

echo "🧪 Testing tmux configuration..."
echo ""

# Test 1: Check tmux version
echo "1️⃣  Checking tmux version..."
tmux -V
echo ""

# Test 2: Verify config syntax
echo "2️⃣  Verifying config syntax..."
if tmux -f ~/.tmux.conf start-server \; display-message "Config OK" 2>&1 | grep -q "Config OK"; then
    echo "✅ Config syntax is valid"
else
    echo "❌ Config has syntax errors"
    tmux -f ~/.tmux.conf start-server 2>&1
fi
echo ""

# Test 3: Check required tools
echo "3️⃣  Checking required tools..."
tools=("fzf" "zoxide" "tmux-mem-cpu-load" "sesh" "eza" "bat" "rg")
for tool in "${tools[@]}"; do
    if command -v "$tool" &> /dev/null; then
        echo "  ✅ $tool: $(command -v $tool)"
    else
        echo "  ❌ $tool: not found"
    fi
done
echo ""

# Test 4: Check TPM installation
echo "4️⃣  Checking TPM (plugin manager)..."
if [ -d ~/.tmux/plugins/tpm ]; then
    echo "  ✅ TPM installed at ~/.tmux/plugins/tpm"
else
    echo "  ⚠️  TPM not found. It will be auto-installed on first tmux launch"
fi
echo ""

# Test 5: Check sesh config
echo "5️⃣  Checking sesh configuration..."
if [ -f ~/.config/sesh/sesh.toml ]; then
    echo "  ✅ Sesh config: ~/.config/sesh/sesh.toml"
else
    echo "  ❌ Sesh config not found"
fi
if [ -f ~/.config/sesh/scripts/snoopy-dev.sh ]; then
    echo "  ✅ Snoopy session script: ~/.config/sesh/scripts/snoopy-dev.sh"
else
    echo "  ❌ Snoopy session script not found"
fi
echo ""

# Test 6: Check color support
echo "6️⃣  Checking terminal color support..."
if [ -n "$COLORTERM" ]; then
    echo "  ✅ COLORTERM=$COLORTERM (true color supported)"
else
    echo "  ⚠️  COLORTERM not set (may need terminal configuration)"
fi
echo "  Current TERM=$TERM"
echo ""

# Test 7: Test sesh functionality
echo "7️⃣  Testing sesh functionality..."
if command -v sesh &> /dev/null; then
    echo "  Available sesh sessions:"
    sesh list 2>/dev/null | head -5 || echo "  (No sessions found)"
else
    echo "  ❌ sesh command not available"
fi
echo ""

# Test 8: Backup verification
echo "8️⃣  Checking backup..."
if [ -d ~/.tmux-backup-20251022 ]; then
    echo "  ✅ Backup exists: ~/.tmux-backup-20251022/"
    ls -la ~/.tmux-backup-20251022/
else
    echo "  ⚠️  No backup found"
fi
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📋 Summary"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "✅ Config file: ~/.tmux.conf"
echo "📚 Cheatsheet: ~/.tmux-cheatsheet.md"
echo "🔧 Shell integration: ~/.tmux-shell-integration.sh"
echo ""
echo "🚀 Next steps:"
echo "  1. Kill existing tmux sessions: tmux kill-server"
echo "  2. Start new tmux session: tmux"
echo "  3. Install plugins: Press Ctrl+b then Shift+I"
echo "  4. Test sesh: Press Ctrl+b then Shift+K"
echo ""
echo "📖 View cheatsheet: cat ~/.tmux-cheatsheet.md"
echo "🎨 Theme: Modern Dark (Vuesion-inspired)"
echo ""
