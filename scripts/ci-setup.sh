#!/bin/sh
export XDG_DATA_HOME="$PWD/.mise/data"
export XDG_STATE_HOME="$PWD/.mise/state"
export XDG_CACHE_HOME="$PWD/.mise/cache"

set -e

echo "CI setup Started"

echo "Installing Mise..."
. "$(dirname "$0")/dependencies/mise.sh"
echo "✅ Mise installed."

echo "Installing Tuist..."
. "$(dirname "$0")/dependencies/tuist.sh"
echo "✅ Tuist installed."

cd RecipeApp

echo "Installing Bundles..."
bundle install
echo "✅ Bundles installed."

echo "Selecting Xcode..."
xcodes select 26.1.1
echo "✅ Xcode selected."

echo "Installing Project dependecies..."
mise exec -C ./RecipeApp/src -- tuist install
echo "✅ Project dependencies installed."

echo "Generating project..."
mise exec -C ./RecipeApp/src -- tuist generate --no-open
echo "✅ Project generated."

echo "✅ CI setup completed."
