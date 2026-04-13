#!/bin/bash
# Clone Flutter with depth 1 to save massive download time and Vercel disk space
if [ ! -d "flutter" ]; then
  git clone https://github.com/flutter/flutter.git -b stable --depth 1
fi

# Add Flutter to the PATH
export PATH="$PATH:`pwd`/flutter/bin"

# Disable analytics to prevent CI prompts from hanging the build
flutter config --no-analytics

# Pre-download binaries specifically for web
flutter precache --web

# Create dummy env files and populate with Vercel environment variables
echo "SUPABASE_URL=$SUPABASE_URL" > .env
echo "SUPABASE_KEY=$SUPABASE_KEY" >> .env
echo "SUPABASE_ANON_KEY=$SUPABASE_ANON_KEY" >> .env
echo "API_BASE_URL=$API_BASE_URL" >> .env
touch .env.example

# Get dependencies and build
flutter pub get
flutter build web --release
