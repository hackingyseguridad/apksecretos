echo
chmod 777 desempaquetar.sh
echo "Uso.: sh desempaquetar.sh nombrep_fichero.apk" 
echo "carpeta /tmp/ para ver los ficheros una vez descomprimidos"
echo 
cd /tmp/
cp $1 /tmp/fichero.zip
unzip -v fichero.zip -d /tmp/

