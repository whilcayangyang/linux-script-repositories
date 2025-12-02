#!/usr/bin/env bash
set -euo pipefail

# Non-interactive installer for Firefox GNOME Theme on LibreWolf (Flatpak)
# - Clones upstream theme repo
# - Runs the provided installer script targeting the LibreWolf profile path

REPO_URL="https://github.com/rafaelmardojai/firefox-gnome-theme.git"
WORKDIR="$(mktemp -d)"
TARGET_PROFILE="/home/whil/.var/app/io.gitlab.librewolf-community/.librewolf"

cleanup() {
  [[ -d "$WORKDIR" ]] && rm -rf "$WORKDIR"
}
trap cleanup EXIT

echo "Cloning Firefox GNOME Theme into $WORKDIR"
git clone --depth=1 "$REPO_URL" "$WORKDIR/firefox-gnome-theme"

echo "Running installer for LibreWolf profile: $TARGET_PROFILE"
cd "$WORKDIR/firefox-gnome-theme/scripts"
./install.sh -f "$TARGET_PROFILE"

echo "Done: Firefox GNOME Theme installed for LibreWolf."
