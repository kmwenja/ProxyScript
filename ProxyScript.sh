function proxyon(){
  export http_proxy=http://$1:$2@$3:$4
  export ftp_proxy=$http_proxy
  export https_proxy=$http_proxy
  export socks_proxy=$http_proxy
  export all_proxy=$http_proxy

sudo sh <<SCRIPT
    # aptitude proxy settings
    if [ -e "/etc/apt/apt.conf" ]; then
       rm -rf /etc/apt/apt.conf
    fi
    
    echo 'Acquire::http::proxy "$http_proxy";' >> /etc/apt/apt.conf
    echo 'Acquire::ftp::proxy "$http_proxy";'>> /etc/apt/apt.conf
    echo 'Acquire::https:proxy "$http_proxy";' >> /etc/apt/apt.conf
    echo 'Acquire::socks::proxy "$http_proxy";' >> /etc/apt/apt.conf

    # ssh proxy settings
    if [ -e "$HOME/.ssh/ssh-config-proxy" ]; then
        cat $HOME/.ssh/ssh-config-proxy > $HOME/.ssh/config 
    fi

SCRIPT
}

function proxyoff(){
  unset http_proxy
  unset https_proxy
  unset ftp_proxy
  unset socks_proxy
  unset all_proxy

sudo sh <<SCRIPT

    # remove aptitude proxy settings
    if [ -e "/etc/apt/apt.conf" ]; then
       rm -rf /etc/apt/apt.conf
    fi

    # remove ssh proxy settings
    if [ -e "$HOME/.ssh/ssh-config-no-proxy" ]; then
        cat $HOME/.ssh/ssh-config-no-proxy > $HOME/.ssh/config
    fi

SCRIPT
}

function proxystatus(){
  if [ -n "$http_proxy" ]; then
     echo "ON"
  else
     echo "OFF"
  fi
}
