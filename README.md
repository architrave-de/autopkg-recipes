# autopkg-recipes

AutoPkg Recipes for JumpCloud

## Remote Commands

### AUTOPKG (1) Install Xcode Command Line Tools

See `autopkg1.sh`

Source: https://github.com/rtrouton/rtrouton_scripts/blob/master/rtrouton_scripts/install_xcode_command_line_tools/install_xcode_command_line_tools.sh

### AUTOPKG (2) Install AutoPkg

See `autopkg2.sh`

### AUTOPKG (3) Install Software

See `autopkg3.sh`

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
