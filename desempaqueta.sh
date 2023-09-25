#!/usr/bin/env bash
echo
chmod 777 desempaqueta.sh
echo "Uso.: sh desempaqueta.sh nombre_fichero.apk" 
echo "carpeta /tmp/ para ver los ficheros una vez descomprimidos"
echo 
cd /tmp/
cp $1 /tmp/fichero.zip
unzip -v fichero.zip -d /tmp/
