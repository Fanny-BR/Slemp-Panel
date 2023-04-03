#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

curPath=`pwd`
rootPath=$(dirname "$curPath")
serverPath=$(dirname "$rootPath")
sourcePath=$serverPath/source/lib
libPath=$serverPath/lib

mkdir -p $sourcePath
mkdir -p $libPath
rm -rf ${libPath}/lib.pl


bash ${rootPath}/scripts/getos.sh
OSNAME=`cat ${rootPath}/data/osname.pl`
VERSION_ID=`cat /etc/*-release | grep VERSION_ID | awk -F = '{print $2}' | awk -F "\"" '{print $2}'`
echo "${OSNAME}:${VERSION_ID}"

# system judge
if [ "$OSNAME" == "macos" ]; then
    brew install libmemcached
    brew install curl
    brew install zlib
    brew install freetype
    brew install openssl
    brew install libzip
elif [ "$OSNAME" == "opensuse" ];then
    echo "opensuse lib"
elif [ "$OSNAME" == "arch" ];then
    echo "arch lib"
elif [ "$OSNAME" == "freebsd" ];then
    echo "freebsd lib"
elif [ "$OSNAME" == "centos" ];then
    echo "centos lib"
elif [ "$OSNAME" == "rocky" ]; then
    echo "rocky lib"
elif [ "$OSNAME" == "fedora" ];then
    echo "fedora lib"
elif [ "$OSNAME" == "alma" ];then
    echo "alma lib"
elif [ "$OSNAME" == "ubuntu" ];then
    echo "ubuntu lib"
elif [ "$OSNAME" == "debian" ]; then
    echo "debian lib"
else
    echo "OK"
fi

PIPSRC="https://pypi.python.org/simple"

if [ ! -f /usr/local/bin/pip3 ] && [ ! -f /usr/bin/pip3 ];then
    python3 -m pip install --upgrade pip setuptools wheel -i $PIPSRC
fi

which pip && pip install --upgrade pip -i $PIPSRC
pip3 install --upgrade pip setuptools wheel -i $PIPSRC
cd ${rootPath} && pip3 install -r ${rootPath}/requirements.txt -i $PIPSRC

# pip3 install flask-caching==1.10.1
# pip3 install mysqlclient

if [ ! -f ${rootPath}/bin/activate ];then
    cd ${rootPath} && python3 -m venv .
    cd ${rootPath} && source ${rootPath}/bin/activate
else
    cd ${rootPath}/panel && source ${rootPath}/bin/activate
fi

pip install --upgrade pip -i $PIPSRC
pip3 install --upgrade setuptools -i $PIPSRC
cd ${rootPath} && pip3 install -r ${rootPath}/requirements.txt -i $PIPSRC

echo "lib ok!"
# pip3 install flask-caching==1.10.1
# pip3 install mysqlclient
