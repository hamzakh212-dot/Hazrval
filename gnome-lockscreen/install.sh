#!/usr/bin/env bash
# Installs a "LiquidGlass" GNOME Shell theme: your current shell theme + the clock style.
# Needs the "User Themes" extension (sudo apt install gnome-shell-extension-manager, enable "User Themes").
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
DEST="$HOME/.local/share/themes/LiquidGlass/gnome-shell"

BASE=""
for c in "$HOME/.local/share/themes/$(gsettings get org.gnome.shell.extensions.user-theme name 2>/dev/null | tr -d "'")/gnome-shell" \
         /usr/share/themes/Yaru/gnome-shell /usr/share/gnome-shell/theme; do
  [ -f "$c/gnome-shell.css" ] && { BASE="$c"; break; }
done
[ -n "$BASE" ] || { echo "Could not find a base gnome-shell.css"; exit 1; }

rm -rf "$DEST"; mkdir -p "$DEST"
cp -r "$BASE"/. "$DEST"/
cat "$HERE/liquid-glass-clock.css" >> "$DEST/gnome-shell.css"
gsettings set org.gnome.shell.extensions.user-theme name 'LiquidGlass'
echo "Installed from $BASE. Press Alt+F2, type r, Enter (X11), or log out and back in (Wayland). Then lock with Super+L."
