#!/usr/bin/env bash
echo
chmod 777 desempaqueta.sh
echo "Uso.: sh desempaqueta.sh nombre_fichero.apk" 
echo "descomprime los arvhicos de la aplicación movil .APK, en la carpeta /tmp/"
echo 
cd /tmp/
cp $1 /tmp/fichero.zip
unzip -v fichero.zip -d /tmp/
