#!/bin/bash

#############################################################

# This script is can be used to quickly run pytest with
# a default test and setup to quickly check the framework
# or a PR with a basic test

# Further, you can make this script an 'alias' in the os:
#    1. Move script to a known location
#    2. Give script permission: 
#          $ sudo chmod +x <script name>
#    3. Add the follwing to .bashrc or .profile:
#          alias pytestq='~/.bashrc_scripts/pytest_quick_test.sh'
#    4. Reload terminal
#    5. Use:
#          $ pytestq

#############################################################

# Directory of pytest repo (omit last forward slash /)
PYTEST_REPO="$HOME/Projects/firmware-systemtest"

# Directory of pytest virtual environment (omit forward slash /)
PYTEST_ENV="$PYTEST_REPO/env"

# Default test
TEST_DEFAULT="test_onoff_via_gw"

# Default setup
SETUP_DEFAULT="gtc_ismet_desk"

# Default RPC Database IP (Jenkins)
IP_JENKINS="10.100.10.4"

#############################################################

# Read first passed parameter (test name)
if [ -z "$1" ]; then 
    TEST=$TEST_DEFAULT
else 
    TEST=$1
fi

# Read second passed parameter (test marker)
if [ -z "$2" ]; then
    SETUP=$SETUP_DEFAULT
else 
    SETUP=$2
fi

# Read thrid passed parameter (additional options)
if [ -z "$3" ]; then
    OPTIONS=$OPTIONS_DEFAULT
else 
    OPTIONS=$3
fi

#############################################################

echo 
echo "[ PYTEST QUICK RUN ] : Pytest quick test run:"
echo "[ PYTEST QUICK RUN ] :     - Test:    '$TEST'"
echo "[ PYTEST QUICK RUN ] :     - Setup:   '$SETUP'"
echo "[ PYTEST QUICK RUN ] :     - Repo:    $PYTEST_REPO"
echo "[ PYTEST QUICK RUN ] :     - venv:    $PYTEST_ENV"
echo "[ PYTEST QUICK RUN ] :     - Options: --sleep-on-fail=0 --logging-level=info --rpc-db-ip-addr=$IP_JENKINS $OPTIONS"

echo "[ PYTEST QUICK RUN ] : Activating virtual environment ..."
cd $PYTEST_REPO
source $PYTEST_ENV/bin/activate

echo "[ PYTEST QUICK RUN ] : Running pytest ..."
echo
pytest -m $SETUP -k $TEST --sleep-on-fail=0 --logging-level=info --rpc-db-ip-addr=$IP_JENKINS $OPTIONS
echo "[ PYTEST QUICK RUN ] : pytest -m $SETUP -k $TEST --sleep-on-fail=0 --logging-level=info --rpc-database-ip-addr=$IP_JENKINS"
echo
echo "[ PYTEST QUICK RUN ] : Deactivating virtual environment ..."
deactivate
echo "[ PYTEST QUICK RUN ] : Done"
echo
