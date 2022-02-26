:: Delete any builds that have been made.
:: This is the nuclear option, bootstrap.sh (or cmake manually) must be
:: run after this.

@ECHO OFF

if exist %~dp0build (
   echo Cleaning all builds...
   rmdir /S /Q %~dp0build
)
