#!/usr/bin/env sh

echo '  '
echo ' ***********************'
echo '*                      *'
echo '* Cleaning build files *'
echo '*                      *'
echo '************************'

echo '  '
echo 'Cleaning up Flutter project...'
fvm flutter clean

echo '  '
echo 'Loading iOS native dependencies...'
fvm flutter precache --ios

echo '  '
echo 'Cleaning up Android project...'
cd android
gradle clean
cd app
gradle clean
cd ../..

echo '  '
echo 'Getting flutter dependencies...'
fvm flutter pub get

echo '  '
echo 'Updating iOS dependencies...'
cd ios
pod repo update
pod update
cd ..

echo '  '
echo 'Done.'
echo ' '
