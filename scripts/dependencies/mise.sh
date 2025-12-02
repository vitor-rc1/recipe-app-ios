#!/bin/sh

# Check if mise is installed
if ! command -v mise >/dev/null 2>&1; then
  echo "❌ mise not found on the system."

  # Install via Homebrew (macOS)
  if command -v brew >/dev/null 2>&1; then
    echo "➡️ Installing mise via Homebrew..."
    brew install mise
  else
    echo "⚠️ Homebrew not found. Please install manually following:"
    echo "https://mise.jdx.dev/getting-started.html"
    exit 1
  fi
else
  echo "✅ mise is already installed."
fi
