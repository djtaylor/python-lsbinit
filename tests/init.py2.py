#!/usr/bin/python
from sys import path
path.append('{PYTHON_PATH}')
from lsbinit import LSBInit, set_environ

### BEGIN INIT INFO
# Provides:          dummy
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Required-Start:    $syslog
# Required-Stop:     $syslog
# X-Interactive:     true
# Short-Description: Dummy Service
# Description:       Dummy service for testing LSBInit
### END INIT INFO

if __name__ == '__main__':

    # Create the service handler
    service = LSBInit(
        name   = 'dummy',
        desc   = 'Dummy testing service',
        pid    = '/tmp/dummy.pid',
        lock   = '/tmp/dummy.lock',
        exe    = ['/tmp/dummy.sh'],
        output = '/tmp/dummy.log'
    )

    # Launch the service handler
    service.interface()