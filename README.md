# LSB Init Manager

A pure Python module used to handle system init scripts.

### Installation
```sh
$ pip install lsbinit
```

### Basic Usage
```python
#!/usr/bin/python
from lsbinit import LSBInit

### BEGIN INIT INFO
# Provides:          service-name
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Required-Start:		$syslog
# Required-Stop:		$syslog
# X-Interactive:     true
# Short-Description: Service Description
# Description:       A more detailed service description
### END INIT INFO

if __name__ == '__main__':
	
	# Create the service handler
	service = LSBInit(
		name   = 'service-name',
		desc   = 'Some service description',
		pid    = '/var/run/service-name.pid',
		lock   = '/var/lock/service-name',
		exe    = ['/usr/bin/service-name'],
		output = '/var/log/service-name/output.log'
	)
	
	# Launch the service handler
	service.interface()
```