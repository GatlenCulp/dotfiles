#!/bin/bash

# Does not work yet!

# Installs these dotfiles into user's home directory. CAREFUL!

# echo "Installing dotfiles..."

# # Define source and backup directories
# DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# BACKUP_DIR="$HOME/.dotfiles.backup.$(date +%Y%m%d_%H%M%S)"

# # Create backup directory
# mkdir -p "$BACKUP_DIR"

# # Function to safely create symlinks
# install_dotfile() {
#     local source="$1"
#     local target="$2"

#     # If target already exists and is not a symlink to our source
#     if [ -e "$target" ] && [ ! -L "$target" -o "$(readlink "$target")" != "$source" ]; then
#         echo "Backing up $target to $BACKUP_DIR/"
#         mv "$target" "$BACKUP_DIR/"
#     fi

#     # Create symlink
#     echo "Creating symlink: $target -> $source"
#     ln -sf "$source" "$target"
# }

# # Install dotfiles
# for file in "$DOTFILES_DIR"/.*; do
#     # Skip . and .. and git-related files
#     basename="$(basename "$file")"
#     if [ "$basename" = "." ] || [ "$basename" = ".." ] || \
#        [ "$basename" = ".git" ] || [ "$basename" = ".gitignore" ]; then
#         continue
#     fi

#     install_dotfile "$file" "$HOME/$basename"
# done

# echo "Installation complete! Backup created in $BACKUP_DIR"
