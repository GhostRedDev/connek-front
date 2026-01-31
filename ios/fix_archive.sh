#!/bin/bash
# Script to regenerate dSYM for WebRTC.framework inside an xcarchive
# Usage: sh fix_archive.sh /path/to/YourApp.xcarchive

ARCHIVE_PATH="$1"

if [ -z "$ARCHIVE_PATH" ]; then
  echo "Usage: $0 /path/to/YourApp.xcarchive"
  exit 1
fi

APP_PATH="$ARCHIVE_PATH/Products/Applications/Runner.app"
FRAMEWORKS_PATH="$APP_PATH/Frameworks"
DSYMS_PATH="$ARCHIVE_PATH/dSYMs"
WEBRTC_FRAMEWORK="$FRAMEWORKS_PATH/WebRTC.framework"

if [ ! -d "$WEBRTC_FRAMEWORK" ]; then
  echo "Error: WebRTC.framework not found at $WEBRTC_FRAMEWORK"
  echo "Checked path: $WEBRTC_FRAMEWORK"
  exit 1
fi

echo "Found WebRTC framework at: $WEBRTC_FRAMEWORK"
echo "Generating dSYM..."

# Ensure dSYMs directory exists
mkdir -p "$DSYMS_PATH"

# Run dsymutil
# Note: The binary inside WebRTC.framework is usually named 'WebRTC'
dsymutil "$WEBRTC_FRAMEWORK/WebRTC" -o "$DSYMS_PATH/WebRTC.framework.dSYM"

if [ $? -eq 0 ]; then
  echo "Success! WebRTC.framework.dSYM created in $DSYMS_PATH"
  echo "You can now proceed with upload via Xcode Organizer or Transporter."
else
  echo "Failed to generate dSYM."
  exit 1
fi
