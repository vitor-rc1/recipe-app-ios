#!/bin/bash

TUIST_VERSION="4.99.0"

echo "🔎 Checking for tuist configuration in this project..."

if ! mise which tuist >/dev/null 2>&1; then
  echo "❌ tuist is not configured for this project."

  if ! command -v mise >/dev/null 2>&1; then
    echo "⚠️ mise is required to configure tuist. Please run dependencies/mise.sh first."
    exit 1
  fi

  echo "➡️ Configuring and installing tuist@$TUIST_VERSION via mise..."
  mise use tuist@$TUIST_VERSION
  
  echo "✅ tuist@$TUIST_VERSION is now configured for this project."
  mise exec -- tuist version
else
  echo "✅ tuist is already configured for this project."
  echo "Active version: $(mise exec -- tuist version)"
fi