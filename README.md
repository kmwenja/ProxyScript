ProxyScript
===========

Script to automate configuring proxy settings.

Configures aptitude, ssh and adds proxy environment variables.

Usage
-----

*These instructions and the script are for linux use only, preferrably Ubuntu*

### Installing

1. Download the repo to a location on your computer
2. Add ```source /path/to/ProxyScript.sh``` to your ```.bashrc``` file.
3. To enable the ProxyScript to start its work, run ```$ source .bashrc```


### Runnning

* Run ```$ proxyon <username> <password> <host> <port> <proxyless-domains>``` when behind a proxy
    * Replace the parameters in ```<...>``` with their equivalent values eg
    ```$ proxyon me pwd myproxy.com 80 localhost,127.0.0.1```
    * The proxyless-domains parameter is a list of domains/urls/ip that should not
    be proxied
    * To reduce all this *typing at prompt work*, you can add the following to ```.bashrc```
    ```
        function myproxy(){
            proxyon <username> <password> <host> <port> <proxyless-domains>
        }
    ```
    *make sure to replace the ```<...>``` parameters with their equivalent values*
* Run ```$ proxyoff``` when not behind a proxy
