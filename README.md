# LSB Init Manager
A pure Python module used to handle system init scripts.
### Installation (APT)
Add the following sources to your apt sources configuration file:
```
deb http://ppa.launchpad.net/djtaylor13/main/ubuntu trusty main 
deb-src http://ppa.launchpad.net/djtaylor13/main/ubuntu trusty main
```
Next import the public key, update software sources, and install:
```sh
$ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D4409661DAA6AF94
$ sudo apt-get update
# Python 2
$ sudo apt-get install python-lsbinit
# Python 3
$ sudo apt-get install python3-lsbinit
```
### Installation (PIP)
```sh
# Python 2
$ sudo pip install lsbinit
# Python 3
$ sudo pip3 install lsbinit 
```

### Basic Usage
```python
#!/usr/bin/python
from lsbinit import LSBInit, set_environ

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
		output = '/var/log/service-name/output.log',
		env    = set_environ(append{
			'HOME': '/home/user'
		})
	)
	
	# Launch the service handler
	service.interface()
```