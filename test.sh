#!/bin/bash
#
# LSBInit Test Runner
# The following shell script is designed to test LSBInit for both Python2
# and Python3. This will install several temporary files, to test running,
# checking status, and stopping a service.

# Local Python path
PYTHON_PATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Dummy service files
DUMMY_INIT="/etc/init.d/dummy"
DUMMY_PID="/tmp/dummy.pid"
DUMMY_LOCK="/tmp/dummy.lock"
DUMMY_BIN="/tmp/dummy.sh"
DUMMY_LOG="/tmp/dummy.log"

if [[ $EUID -ne 0 ]]; then
   echo -e "\nERROR"
   echo -e "---------------------------------------------------------------"
   echo -e "Test runner for python-lsbinit must be run as root. This script"
   echo -e "will install the following temporary files:\n"
   echo -e "Init: $DUMMY_INIT"
   echo -e "PID: $DUMMY_PID"
   echo -e "Lock: $DUMMY_LOCK"
   echo -e "BIN: $DUMMY_BIN"
   echo -e "Log: $DUMMY_LOG\n"
   exit 1
fi

do_sed_string() {
	
	# Retrieve 'input string' argument
    INPUT_STRING="$1"

    # Process SED metacharacters
    SED_META1="${INPUT_STRING//\//\\/}"
    SED_META2="${SED_META1//\^/\\^}"
    SED_META3="${SED_META2//\./\\.}"
    SED_META4="${SED_META3//\*/\\*}"
    SED_META5="${SED_META4//\$/\\$}"
    SED_META6="${SED_META5//\+/\\+}"
    SED_META7="${SED_META6//\[/\\[}"
    SED_META8="${SED_META7//\]/\\]}"
    SED_META9="${SED_META8//\</\\<}"
    SED_META10="${SED_META9//\>/\\>}"
    SED_META11="${SED_META10//\@/\\@}"

    # Define SED friendly string
    SED_STRING="$SED_META11"

    # Echo SED friendly string
    echo "$SED_STRING"
	
}

do_rm() {
    FILE=$1
    echo -e "Removing file: $FILE"
    rm -f $FILE
}

do_update_python_path() {
    
    # Target file / Python path
    TARGET_FILE=$1
    PYTHON_PATH=$2
    
    # Update the Python path
    sed -i "s/{PYTHON_PATH}/$(do_sed_string "$PYTHON_PATH")/g" $TARGET_FILE
}

do_setup() {
    INIT_SCRIPT="$1"
    
    # Create the init.d script and update the Python path
    cp $INIT_SCRIPT $DUMMY_INIT && chmod +x $INIT_SCRIPT
    do_update_python_path "$DUMMY_INIT" "$PYTHON_PATH"
    echo "Creating dummy init script: $DUMMY_INIT"
    
    # Create the executable
    cp tests/dummy.sh $DUMMY_BIN && chmod +x $DUMMY_BIN
    echo "Creating dummy executable: $DUMMY_BIN"
    
    # Update init.d services
    echo "Installing dummy service..."
    update-rc.d dummy defaults
}

do_tests() {
    echo 'STATUS:::'
    service dummy status
    echo "STARTING:::"
    service dummy start
    echo 'STATUS:::'
    service dummy status
    echo "RESTARTING:::"
    service dummy restart
    echo 'STATUS:::'
    service dummy status
    echo "STOPPING:::"
    service dummy stop
    echo 'STATUS:::'
    service dummy status
}

do_cleanup() {
    
    # Remove dummy files
    echo -e "Removing dummy service files..."
    do_rm $DUMMY_INIT
    do_rm $DUMMY_PID
    do_rm $DUMMY_LOCK
    do_rm $DUMMY_LOG
    do_rm $DUMMY_BIN
    
    # Uninstall the service
    echo -e "Uninstalling dummy service..."
    update-rc.d dummy remove
}

# Run Python2 tests
do_py2() {
    echo -e "---------------------------------------------------------------"
    echo -e "Running Python2 tests..."
    echo -e "---------------------------------------------------------------"
    do_setup "tests/lsbinit.py2.py"
    do_tests
    do_cleanup
    echo -e "---------------------------------------------------------------"
    echo -e "Python2 tests complete!"
    echo -e "---------------------------------------------------------------"
}

# Run Python3 tests
do_py3() {
    echo -e "Running Python3 tests..."
    echo -e "---------------------------------------------------------------"
    do_setup "tests/lsbinit.py3.py"
    do_tests
    do_cleanup
    echo -e "---------------------------------------------------------------"
    echo -e "Python3 tests complete!"
    echo -e "---------------------------------------------------------------"
}

do_py2
do_py3
exit 0