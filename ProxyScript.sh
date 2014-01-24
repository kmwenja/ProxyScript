function setaptproxy(){
    http_proxy=$1
sudo sh <<SCRIPT
    # aptitude proxy settings
    if [ -e "/etc/apt/apt.conf" ]; then
       rm -rf /etc/apt/apt.conf
    fi
    
    echo 'Acquire::http::proxy "$http_proxy";' >> /etc/apt/apt.conf
    echo 'Acquire::ftp::proxy "$http_proxy";'>> /etc/apt/apt.conf
    echo 'Acquire::https:proxy "$http_proxy";' >> /etc/apt/apt.conf
    echo 'Acquire::socks::proxy "$http_proxy";' >> /etc/apt/apt.conf


SCRIPT
}

function setsshproxy(){
    # ssh proxy settings
    if [ -e "$HOME/.ssh/ssh-config-proxy" ]; then
        cat $HOME/.ssh/ssh-config-proxy > $HOME/.ssh/config 
    fi
}

function setenvproxy(){
  PROXY_ENV="http_proxy ftp_proxy https_proxy socks_proxy all_proxy HTTP_PROXY HTTPS_PROXY FTP_PROXY SOCKS_PROXY ALL_PROXY"
  for env in $PROXY_ENV
  do
    export $env=$1
  done

  # add default no proxy
  NO_PROXY_ENV="no_proxy NO_PROXY"
  for env in $NO_PROXY_ENV
  do
    export $env=$2
  done
}

function proxyon(){
  proxy_value=http://$1:$2@$3:$4
  setenvproxy $proxy_value $5
  setaptproxy $proxy_value
  setsshproxy
}

function unsetenvproxy(){
  setenvproxy
}

function unsetaptproxy(){
sudo sh <<SCRIPT
    # remove aptitude proxy settings
    if [ -e "/etc/apt/apt.conf" ]; then
       rm -rf /etc/apt/apt.conf
    fi
SCRIPT
}

function unsetsshproxy(){
    # remove ssh proxy settings
    if [ -e "$HOME/.ssh/ssh-config-no-proxy" ]; then
        cat $HOME/.ssh/ssh-config-no-proxy > $HOME/.ssh/config
    fi
}

function proxyoff(){
    unsetenvproxy
    unsetaptproxy
    unsetsshproxy
}

function proxystatus(){
  if [ -n "$http_proxy" ]; then
     echo "ON"
  else
     echo "OFF"
  fi
}
