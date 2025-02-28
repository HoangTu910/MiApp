#!/bin/bash

echo "Cleaning Flutter project..."
flutter clean

echo "Fetching dependencies..."
flutter pub get

echo "Running the app..."
flutter run
