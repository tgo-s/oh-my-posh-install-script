#!/usr/bin/env bash

set -e  # Exit on error

echo "🔄 Updating package list..."
sudo apt update

echo "📦 Installing dependencies..."
sudo apt install -y wget unzip

echo "⬇️ Downloading Oh My Posh..."
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O oh-my-posh
chmod +x oh-my-posh
sudo mv oh-my-posh /usr/local/bin/oh-my-posh

echo "🎨 Setting up themes..."
mkdir -p ~/.poshthemes
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O themes.zip
unzip -o themes.zip -d ~/.poshthemes
chmod u+rw ~/.poshthemes/*.omp.json
rm themes.zip

echo "⚙️ Adding Oh My Posh to shell..."
PROFILE_FILE="$HOME/.bashrc"
if ! grep -q "oh-my-posh" "$PROFILE_FILE"; then
    echo 'eval "$(oh-my-posh init bash --config ~/.poshthemes/rudolfs-dark.omp.json)"' >> "$PROFILE_FILE"
    echo "✅ Oh My Posh added to $PROFILE_FILE"
else
    echo "ℹ️ Oh My Posh already configured in $PROFILE_FILE"
fi

echo "✅ Installation complete! Restart your shell or run: source ~/.bashrc"
