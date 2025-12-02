#!/bin/bash
set -euo pipefail

# Download URLs per app
PASS_DEB_URL="https://proton.me/download/PassDesktop/linux/x64/ProtonPass.deb"
PASS_RPM_URL="https://proton.me/download/PassDesktop/linux/x64/ProtonPass.rpm"
AUTHENTICATOR_DEB_URL="https://proton.me/download/authenticator/linux/ProtonAuthenticator.deb"
AUTHENTICATOR_RPM_URL="https://proton.me/download/authenticator/linux/ProtonAuthenticator.rpm"
MAIL_DEB_URL="https://proton.me/download/mail/linux/ProtonMail-desktop-beta.deb"
MAIL_RPM_URL="https://proton.me/download/mail/linux/ProtonMail-desktop-beta.rpm"

# Temporary directory for downloads
TEMP_DIR="/tmp/proton-downloads"
mkdir -p "$TEMP_DIR" || { echo "Failed to create temporary directory"; exit 1; }

# Log function
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Detect package manager
detect_pkg_type() {
    if command -v apt &>/dev/null; then
        echo "deb"
    elif command -v dnf &>/dev/null || command -v rpm &>/dev/null; then
        echo "rpm"
    else
        echo "unknown"
    fi
}

PKG_TYPE=$(detect_pkg_type)
if [[ "$PKG_TYPE" == "unknown" ]]; then
    echo "No supported package manager found (apt or dnf/rpm)."; exit 1;
fi

# Download helper
download_file() {
    local url="$1"
    local filename="$2"
    log "Downloading $filename..."
    wget "$url" -O "$TEMP_DIR/$filename" || { echo "Failed to download $filename"; exit 1; }
    log "$filename downloaded successfully."
}

# Install helper
install_package() {
    local filename="$1"
    local ext="${filename##*.}"
    log "Installing $filename..."
    if [[ "$ext" == "deb" ]]; then
        sudo apt install -y "$TEMP_DIR/$filename" || { echo "Failed to install $filename"; exit 1; }
    elif [[ "$ext" == "rpm" ]]; then
        sudo dnf install -y "$TEMP_DIR/$filename" || { echo "Failed to install $filename"; exit 1; }
    else
        echo "Unknown package type for $filename"; exit 1;
    fi
    log "$filename installed successfully."
}

# Prompt selection
echo "Select the Proton app to install:"
echo "  1) Proton Pass"
echo "  2) Proton Authenticator"
echo "  3) Proton Mail (beta desktop)"
read -r -p "Enter choice [1-3]: " choice

case "$choice" in
    1)
        if [[ "$PKG_TYPE" == "deb" ]]; then
            download_file "$PASS_DEB_URL" "proton-pass-desktop.deb"
            install_package "proton-pass-desktop.deb"
        else
            download_file "$PASS_RPM_URL" "proton-pass-desktop.rpm"
            install_package "proton-pass-desktop.rpm"
        fi
        ;;
    2)
        if [[ "$PKG_TYPE" == "deb" ]]; then
            download_file "$AUTHENTICATOR_DEB_URL" "proton-authenticator.deb"
            install_package "proton-authenticator.deb"
        else
            download_file "$AUTHENTICATOR_RPM_URL" "proton-authenticator.rpm"
            install_package "proton-authenticator.rpm"
        fi
        ;;
    3)
        if [[ "$PKG_TYPE" == "deb" ]]; then
            download_file "$MAIL_DEB_URL" "proton-mail-desktop-beta.deb"
            install_package "proton-mail-desktop-beta.deb"
        else
            download_file "$MAIL_RPM_URL" "proton-mail-desktop-beta.rpm"
            install_package "proton-mail-desktop-beta.rpm"
        fi
        ;;
    *)
        echo "Invalid choice."; exit 1;
        ;;
esac

# Clean up
log "Cleaning up temporary files..."
rm -rf "$TEMP_DIR" || { echo "Failed to clean up temporary directory"; exit 1; }

log "Installation completed successfully."