#!/bin//bash
# run this file from your application's root directory

# this will trap any errors or commands with non-zero exit status
# by calling function catch_errors()
trap catch_errors ERR;
function catch_errors() {
   EXITCODE=$?
   # do whatever on errors
   echo ""
   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   echo "nightwatch aborted with a status code of $EXITCODE"
   echo "!!!!!!!!"
   exit $EXITCODE;
}

# defaults
CONFIG="tests/nightwatch/config.json"
ENVIRONMENT="default"
_TESTS=""
_GROUP=""
_SKIP=""
_FILTER=""
_VERBOSE=""
_HELP=""
_ARGS=false

function usage()
{
    echo "Nightwatch Test Runner"
    echo ""
    echo "./spec"
    echo "\t-H this script's help"
    echo "\t-h --help Nightwatch's help"
    echo "\t-e | --environment=$ENVIRONMENT (CSV)"
    echo "\t-c | --config=$CONFIG"
    echo "\t-t | --test which test file to run (webapp path)"
    echo "\t-g | --group which group of tests to run"
    echo "\t-s | --skipgroup of group to skip (CSV)"
    echo "\t-f | --filter test file names (glob expression)i eg: '*table*'"
    echo "\t-v | --verbose see more output from Selenium"
    echo ""
}

while getopts "hHe:c:t:g:s:f:v" opt; do

  case $opt in
    H | --HELP)
        usage
        exit;;
    h | --help)
        _HELP=" --help"
        ;;
    v | --verbose)
        _VERBOSE=" --verbose"
        ;;
    c)
        CONFIG=$OPTARG
        ;;
    e | -E | --env | --environment)
        ENVIRONMENT=$OPTARG
        ;;
    t)
        _TESTS=" -t $OPTARG"
        ;;
    g)
        _GROUP=" -g $OPTARG"
        ;;
    s | --skipgroup)
        _SKIP=" -s $OPTARG"
        ;;
    f | --filter)
        _FILTER=" -f $OPTARG"
        ;;
    \?)
        echo "Invalid option -$OPTARG" >& 2
        ;;
    esac
done


# TODO cd into the app dir as PWD

# Setup: changing file permissions"
mkdir -p .meteor/local/build/programs/server/assets/packages/clinical_nightwatch
chmod +x .meteor/local/build/programs/server/assets/packages/clinical_nightwatch/launch_nightwatch*.sh
chmod +x .meteor/local/build/programs/server/assets/packages/clinical_nightwatch/selenium/chromedriver
mkdir -p tests/logs
chmod 0777 tests/logs

# Setup: look for Nightwatch executable
NWBIN=".meteor/local/build/node_modules/nightwatch/bin/nightwatch"

if [ ! -f $NWBIN ]; then
    NWBIN="node_modules/nightwatch/bin/nightwatch"
fi
if [ ! -f $NWBIN ]; then
    NWBIN="../node_modules/nightwatch/bin/nightwatch"
fi
if [ ! -f $NWBIN ]; then
    NWBIN="../../node_modules/nightwatch/bin/nightwatch"
fi
if [ ! -f $NWBIN ]; then
    NWBIN="../../node_modules/nightwatch/bin/nightwatch"
fi
if [ ! -f $NWBIN ]; then
    # Setup: Nightwatch executable not found, install it
    echo "  installing nightwatch in .meteor/local/build"
    # or, depending on Node, might roll up to Dart repo parent
    cd .meteor/local/build
    npm install nightwatch@0.5
    cd ../../..
    NWBIN=".meteor/local/build/node_modules/nightwatch/bin/nightwatch"
fi
if [ ! -f $NWBIN ]; then
    echo "ERROR: nightwatch binary - File not found!"
    PWD=`pwd`
    echo "  pwd: $PWD"
    echo "  NWBIN: $NWBIN"
    echo "ls .meteor/local/build/node_modules/"
    ls .meteor/local/build/node_modules/
    exit 1
fi


# Build and run nightwatch command
#   always include the ENVIRONMENT and CONFIG params
CMD="$NWBIN -e $ENVIRONMENT -c $CONFIG$_TESTS$_GROUP$_SKIP$_FILTER$_VERBOSE$_HELP"
echo "   run   $CMD"

if [ -n "$_VERBOSE" ]; then
    echo ""
    echo "  $NWBIN"
    echo "    -e $ENVIRONMENT"
    echo "    -c $CONFIG"
    echo "   $_TESTS   (test)"
    echo "   $_GROUP   (group)"
    echo "   $_SKIP   (skip)"
    echo "   $_FILTER   (filter)"
    echo "   $_VERBOSE   (verbose)"
    echo "   $_HELP   (help)"
fi
echo ""
echo ""

# run nightwatch command
eval $CMD

# if we made it here... we're good
#   errors/exits should have been trapped above
echo ""
echo "nightwatch completed with a status code of $?"
echo ""
echo "              ____"
echo "            /____ \`\\"
echo "           ||_  _\`\ \\"
echo "     .-.   \`|O, O  ||"
echo "     | |    (/    -)\\"
echo "     | |    |\`-'\` |\\\`"
echo "  __/  |    | _/  |"
echo " (___) \\.  _.\\__. \`\\___"
echo " (___)  )\/  \\    _/  ~\."
echo " (___) . \\   \`--  _    \`\\"
echo "  (__)-    ,/        (   |"
echo "       \`--~|         |   |"
echo "           |         |   | You Win!"


# return exit code 0
exit 0
