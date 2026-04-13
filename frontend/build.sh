#!/bin/bash
# Install Flutter from the stable channel
if [ ! -d "flutter" ]; then
  git clone https://github.com/flutter/flutter.git -b stable
fi

# Add Flutter to the PATH
export PATH="$PATH:`pwd`/flutter/bin"

# Enable web support (just in case)
flutter config --enable-web

# Get dependencies and build
flutter pub get
flutter build web --release
