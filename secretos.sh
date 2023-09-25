#!/bin/bash
echo
echo "Busca secretos en los ficheros de la carpeta /tmp/"
echo
grep  -Hrn "http*" /tmp/
grep  -Hrn "token*" /tmp
grep  -Hrn "password*" /tmp
grep  -Hrn "auth" /tmp
grep  -Hrn "api" /tmp
grep  -Hrn "sql" /tmp
grep  -Hrn "Digest" /tmp
grep  -Hrn "email" /tmp
grep  -Hrn "ouath2" /tmp 
