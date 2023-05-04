[adoptium]
name=Adoptium - Temurin Java
baseurl=https://packages.adoptium.net/artifactory/rpm/centos/\$releasever/\$basearch
enabled=1
gpgcheck=1
gpgkey=https://packages.adoptium.net/artifactory/api/gpg/key/public




alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/temurin-11-jre/bin/java" "1100" --family "temurin-11"





reboot




export http_proxy=http://proxy.gls-group.eu:8080
export https_proxy=http://proxy.gls-group.eu:8080
export no_proxy=127.0.0.1,localhost

export http_proxy=http://{Proxy-User-Name}:{Proxy-Password}@<Proxy-Server-IP-Address>:<Proxy-Port>
export https_proxy= http://{Proxy-User-Name}:{Proxy-Password}@<Proxy-Server-IP-Address>:<Proxy-Port>
export no_proxy=127.0.0.1,localhost

export ftp_proxy= http://{Proxy-User-Name}:{Proxy-Password}@<Proxy-Server-IP-Address>:<Proxy-Port>
