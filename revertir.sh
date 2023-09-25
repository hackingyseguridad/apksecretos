#!/usr/bin/env bash
echo 
chmod 777 revertir.sh
echo "Uso.: sh revertir.sh nombre_fichero.apk" 
echo 
echo " - descomprime los arvhicos de la aplicacion movil .APK, en la carpeta /tmp/ !!!"
echo 
cd /tmp/
cp $1 /tmp/fichero.zip
unzip fichero.zip -d /tmp/
