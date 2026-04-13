---
name: setup
description: Install the Browser Bridge extension into Chrome or Brave
user_invocable: true
---

# Browser Bridge Extension Setup

Guide the user through loading the Browser Bridge extension into their browser.

## Steps

1. **Find the extension directory.** The extension ships with this plugin at `${CLAUDE_PLUGIN_ROOT}/extension/`. Confirm the directory exists by checking for `manifest.json` inside it.

2. **Detect the browser.** Ask the user which browser they use, or check:
   - Brave: `which brave-browser` or `which brave`
   - Chrome: `which google-chrome` or `which chromium-browser`
   - Edge: `which microsoft-edge`

3. **Give browser-specific instructions.** Print clear step-by-step instructions:

   ### Brave
   1. Open `brave://extensions` in the address bar
   2. Enable **Developer mode** (toggle in top-right corner)
   3. Click **Load unpacked**
   4. Navigate to and select: `${CLAUDE_PLUGIN_ROOT}/extension/`
   5. The "Browser Bridge" extension should appear with an **ON** badge when connected

   ### Chrome
   1. Open `chrome://extensions` in the address bar
   2. Enable **Developer mode** (toggle in top-right corner)
   3. Click **Load unpacked**
   4. Navigate to and select: `${CLAUDE_PLUGIN_ROOT}/extension/`
   5. The "Browser Bridge" extension should appear with an **ON** badge when connected

   ### Edge
   1. Open `edge://extensions` in the address bar
   2. Enable **Developer mode** (toggle in bottom-left)
   3. Click **Load unpacked**
   4. Navigate to and select: `${CLAUDE_PLUGIN_ROOT}/extension/`
   5. The "Browser Bridge" extension should appear with an **ON** badge when connected

4. **Verify the connection.** After the user confirms the extension is loaded:
   - Use `list_tabs` to verify the bridge is working
   - If it fails, check that the daemon is running (`daemon_status` for `claude-browser-bridge`)
   - The extension icon shows a green **ON** badge when connected to the daemon

5. **Troubleshooting tips** (only if needed):
   - No ON badge: the daemon isn't running yet. It starts automatically on first browser tool use.
   - Extension errors: open the browser's extension page, click "Errors" on the Browser Bridge card
   - After plugin updates: reload the extension from the extensions page (the version number in the card confirms the right code is loaded)

## Output format

Print the resolved extension path and the instructions for their browser. Keep it concise. Don't print instructions for browsers they aren't using.
