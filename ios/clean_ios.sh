#!/bin/bash
# Script to completely clean and rebuild the iOS project
# Run this from the project root or ios/ folder.

echo "----------------------------------------------------------------"
echo "  🧹 CLEANING IOS PROJECT (DEEP CLEAN)"
echo "----------------------------------------------------------------"

# Determine if we are in root or ios/
if [ -d "ios" ]; then
    cd ios
fi

# 1. Remove Pods and Lockfile
echo "Removing Pods and Podfile.lock..."
rm -rf Pods
rm -rf Podfile.lock

# 1b. Remove Generated Plugin Registrant (Force regeneration)
echo "Removing GeneratedPluginRegistrant..."
rm -f Runner/GeneratedPluginRegistrant.h
rm -f Runner/GeneratedPluginRegistrant.m

# 2. Remove Flutter Generated files
echo "Removing Flutter Build artifacts..."
rm -rf Flutter/Flutter.podspec
# Note: Do NOT remove Generated.xcconfig as it's needed for pod install, 
# but usually 'flutter pub get' regenerates it.
# We will do a full flutter clean from root to be safe.

cd .. # Go back to root

# 3. Flutter Clean
echo "Running flutter clean..."
flutter clean

# 4. Flutter Pub Get
echo "Running flutter pub get..."
flutter pub get

# 5. Pod Install
echo "Installing Pods (with repo update)..."
cd ios
pod install --repo-update

echo "----------------------------------------------------------------"
echo "  ✅ CLEANUP COMPLETE"
echo "----------------------------------------------------------------"
echo "Now run: flutter build ios"
