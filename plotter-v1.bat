@echo off
:: Note that if you move plot with a .plot to destination Chia will call it invalid, hence why the rename before moving.
:: Put this batch file in same directory as the MM Plotter
:: Paste your farmkey and poolkey
:: Modify your drive letters on lines 17, 24, 27, 30
:: Use and modify this script are your own risk
::
:: Starting script
:start
TITLE MadMax-Plotter v0.0.3 with Robocopy

:: Set public keys
set farmkey=
set poolkey=

:: Creating plot syntax with MadMax
chia_plot -p %poolkey% -f %farmkey% -t D:\ -r 6 -u 256

:: Give time to user to mark the timings before clearing
TIMEOUT 30
cls

:: Rename to temp - ren <plotter_drive>*.temp *.plot
ren D:\*.plot *.temp

:: Moving plot - robocopy <plotter_drive> <dest> <file> /J /MOV /TEE /MT:<#Cores> /log+:plots.log
robocopy D:\ S:\solo *.temp /J /MOV /TEE /MT:6 /log+:plots.log

:: Rename plot in destination - ren <dest>*.temp *.plot
ren S:\solo\*.temp *.plot

:: Sleep 60 seconds wait if you want to cancel loop
TIMEOUT 60
cls

goto start