CONFIG_PATH="$SRCROOT/../../.swiftlint.yml"

SWIFT_PACKAGE_DIR="${BUILD_DIR%Build/*}SourcePackages/artifacts"
SWIFTLINT_CMD="$SWIFT_PACKAGE_DIR/swiftlintplugins/SwiftLintBinary/SwiftLintBinary.artifactbundle/macos/swiftlint"

if test -f "$SWIFTLINT_CMD" 2>&1
then
    "$SWIFTLINT_CMD" --config "$CONFIG_PATH"
else
    echo "warning: `swiftlint` command not found - See https://github.com/realm/SwiftLint#xcode-run-script-build-phase for installation instructions."
fi