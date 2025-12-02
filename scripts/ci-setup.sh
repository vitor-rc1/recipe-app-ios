#!/bin/sh
export XDG_DATA_HOME="$PWD/.mise/data"
export XDG_STATE_HOME="$PWD/.mise/state"
export XDG_CACHE_HOME="$PWD/.mise/cache"

. "$(dirname "$0")/dependencies/mise.sh"
. "$(dirname "$0")/dependencies/tuist.sh"

echo "✅ CI setup completed."
