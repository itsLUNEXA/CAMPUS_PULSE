@echo off
title Campus Pulse - Backend Server
echo ===================================================
echo Starting Campus Pulse Serverpod Backend...
echo (Keep this window open while using the app)
echo ===================================================
cd /d "%~dp0campus_pulse_server"
dart bin/main.dart --mode development
pause

