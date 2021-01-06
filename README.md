# autopkg-recipes

AutoPkg Recipes for JumpCloud

## Remote Commands

### 1. AUTOPKG (1) Install Xcode Command Line Tools

```bash
#!/bin/bash

# Installing the Xcode command line tools on 10.7.x or higher

# Save current IFS state
OLDIFS=$IFS
IFS='.' read osvers_major osvers_minor osvers_dot_version <<< "$(/usr/bin/sw_vers -productVersion)"

# restore IFS to previous state
IFS=$OLDIFS
cmd_line_tools_temp_file="/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress"

# Installing the latest Xcode command line tools on 10.9.x or higher
if [[ ( ${osvers_major} -eq 10 && ${osvers_minor} -ge 9 ) || ( ${osvers_major} -eq 11 && ${osvers_minor} -ge 0 ) ]]; then
	# Create the placeholder file which is checked by the softwareupdate tool
	# before allowing the installation of the Xcode command line tools.
	touch "$cmd_line_tools_temp_file"

	# Identify the correct update in the Software Update feed with "Command Line Tools" in the name for the OS version in question.
	if [[ ( ${osvers_major} -eq 10 && ${osvers_minor} -ge 15 ) || ( ${osvers_major} -eq 11 && ${osvers_minor} -ge 0 ) ]]; then
	   cmd_line_tools=$(softwareupdate -l | awk '/\*\ Label: Command Line Tools/ { $1=$1;print }' | sed 's/^[[ \t]]*//;s/[[ \t]]*$//;s/*//' | cut -c 9-)
	elif [[ ( ${osvers_major} -eq 10 && ${osvers_minor} -gt 9 ) ]] && [[ ( ${osvers_major} -eq 10 && ${osvers_minor} -lt 15 ) ]]; then
	   cmd_line_tools=$(softwareupdate -l | awk '/\*\ Command Line Tools/ { $1=$1;print }' | grep "$macos_vers" | sed 's/^[[ \t]]*//;s/[[ \t]]*$//;s/*//' | cut -c 2-)
	elif [[ ( ${osvers_major} -eq 10 && ${osvers_minor} -eq 9 ) ]]; then
	   cmd_line_tools=$(softwareupdate -l | awk '/\*\ Command Line Tools/ { $1=$1;print }' | grep "Mavericks" | sed 's/^[[ \t]]*//;s/[[ \t]]*$//;s/*//' | cut -c 2-)
	fi

	# Check to see if the softwareupdate tool has returned more than one Xcode
	# command line tool installation option. If it has, use the last one listed
	# as that should be the latest Xcode command line tool installer.
	if (( $(grep -c . <<<"$cmd_line_tools") > 1 )); then
	   cmd_line_tools_output="$cmd_line_tools"
	   cmd_line_tools=$(printf "$cmd_line_tools_output" | tail -1)
	fi

	#Install the command line tools
	softwareupdate -i "$cmd_line_tools" --verbose

	# Remove the temp file
	if [[ -f "$cmd_line_tools_temp_file" ]]; then
	  rm "$cmd_line_tools_temp_file"
	fi
fi

exit 0
```

Source: https://github.com/rtrouton/rtrouton_scripts/blob/master/rtrouton_scripts/install_xcode_command_line_tools/install_xcode_command_line_tools.sh

### AUTOPKG (2) Install AutoPkg

```bash
#!/bin/bash

V="2.2"

curl -o /tmp/autopkg.pkg -fsSL "https://github.com/autopkg/autopkg/releases/download/v$V/autopkg-$V.pkg"
installer -pkg /tmp/autopkg.pkg -target /

exit 0
```

### AUTOPKG (3) Install Default Software

```bash
#!/bin/bash

APKG="/usr/local/bin/autopkg"
PARAMS="install --check --verbose"

REPO="https://github.com/architrave-de/autopkg-recipes"

$APKG repo-add $REPO
$APKG repo-update $REPO

$APKG $PARAMS "1Password"
$APKG $PARAMS "Atom"
$APKG $PARAMS "Firefox"
$APKG $PARAMS "Firefox Developer Edition"
$APKG $PARAMS "Google Chrome"
$APKG $PARAMS "Google Drive"
$APKG $PARAMS "Google Drive File Stream"
$APKG $PARAMS "iTerm2"
$APKG $PARAMS "Itsycal"
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
```

## Create Recipes

Download `Recipe Robot` from here: https://github.com/homebysix/recipe-robot/releases

Symlink the command line tool:

```bash
sudo ln -nfs /Applications/Recipe\ Robot.app/Contents/Resources/scripts/recipe-robot /usr/local/bin/recipe-robot
```

Get an universal download link, f.i. https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg

Create the recipe:

```bash
recipe-robot -v "https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg"
```

Done!
