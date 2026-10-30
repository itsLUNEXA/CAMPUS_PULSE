@echo off
title Campus Pulse - Flutter Web App
echo ===================================================
echo Starting Campus Pulse Flutter Frontend in Chrome...
echo ===================================================
cd /d "%~dp0campus_pulse_flutter"
flutter run -d chrome
pause

