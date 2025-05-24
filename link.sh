#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

# 対象ファイル（dotfilesリポジトリ内のファイル名）
FILES=(
  .tmux.conf
)

echo "Backing up existing dotfiles to $BACKUP_DIR..."
mkdir -p "$BACKUP_DIR"

for file in "${FILES[@]}"; do
  src="$DOTFILES_DIR/$file"
  dest="$HOME/$file"

  # 既存ファイルがある場合はバックアップ
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    mkdir -p "$(dirname "$BACKUP_DIR/$file")"
    mv "$dest" "$BACKUP_DIR/$file"
  fi

  echo "Linking $src -> $dest"
  mkdir -p "$(dirname "$dest")"
  ln -s "$src" "$dest"
done

