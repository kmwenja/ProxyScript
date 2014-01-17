ProxyScript
===========

Script to automate configuring proxy settings.

Configures aptitude, ssh and adds proxy environment variables.

Usage
-----

1. Add ```source ProxyScript``` to .bashrc
2. Set proxy settings using ```proxyon <username> <password> <host> <port>``` or
    add a bash function to do that for you eg
```
    function myproxy(){
        proxyon <username> <password> <host> <port>
    }
```
3. For ssh, you need to add ```ssh-config-proxy``` and ```ssh-config-no-proxy``` to .ssh
4. Run ```source .bashrc``` to install everything or restart your terminal.
5. Run ```proxyon``` to activate and ```proxyoff``` to deactivate.
