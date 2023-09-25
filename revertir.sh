#!/usr/bin/env bash
echo
chmod 777 revetir.sh
echo "Uso.: sh revertir.sh nombre_fichero.apk" 
echo "descomprime los arvhicos de la aplicación movil .APK, en la carpeta /tmp/"
echo 
cd /tmp/
cp $1 /tmp/fichero.zip
unzip -v fichero.zip -d /tmp/
