#!/bin/bash

APKG="/usr/local/bin/autopkg"
PARAMS="install --verbose"

REPO="https://github.com/architrave-de/autopkg-recipes"

$APKG repo-add $REPO
$APKG repo-update $REPO

$APKG $PARAMS "1Password"
$APKG $PARAMS "AppCleaner"
$APKG $PARAMS "Atom"
$APKG $PARAMS "Firefox"
$APKG $PARAMS "Firefox Developer Edition"
$APKG $PARAMS "Google Chrome"
$APKG $PARAMS "Google Drive"
$APKG $PARAMS "Itsycal"
$APKG $PARAMS "iTerm2"
$APKG $PARAMS "KeepingYouAwake"
$APKG $PARAMS "Keka"
$APKG $PARAMS "Microsoft Edge"
$APKG $PARAMS "nvALT"
$APKG $PARAMS "Rectangle"
$APKG $PARAMS "Slack"
$APKG $PARAMS "TeamViewer"
$APKG $PARAMS "Tunnelblick"
$APKG $PARAMS "Visual Studio Code"

exit 0
