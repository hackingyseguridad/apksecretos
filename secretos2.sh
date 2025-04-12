#!/bin/sh

# ==================================================
# APK_SECRET_SCAN v1.0
# Escáner de secretos en archivos .apk (Android)
# Compatible con Bash 1.x+ y shells antiguas
# ==================================================

# Configuración
TMPDIR="/tmp/apkscan_$$"
mkdir "$TMPDIR" || exit 1
LOG="$TMPDIR/scan.log"

# Funciones básicas
error() {
  echo "ERROR: $1"
  rm -rf "$TMPDIR"
  exit 1
}

# Verificar comandos
for cmd in unzip grep sed strings file; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    error "Falta comando: $cmd"
  fi
done

# Verificar argumentos
if [ $# -lt 1 ]; then
  echo "Uso: $0 archivo.apk"
  echo "Ejemplo: $0 aplicacion.apk"
  exit 1
fi

APK="$1"

# Verificar si es archivo APK
if ! file "$APK" | grep -q "Zip archive"; then
  error "El archivo no parece ser un APK válido"
fi

# Extraer APK
echo "Extrayendo APK..." >> "$LOG"
unzip -q "$APK" -d "$TMPDIR" 2>> "$LOG" || error "Error al extraer APK"

# Patrones de búsqueda
PATTERNS='
api.?key
secret.?key
[A-Za-z0-9_\-]{24,}
AKIA[0-9A-Z]{16}
eyJ[a-zA-Z0-9_\-]+\.[a-zA-Z0-9_\-]+\.[a-zA-Z0-9_\-]+
password
token
access
credentials
'

# Escanear archivos
echo ""
echo "=== RESULTADOS DEL ESCANEO ==="
echo "Aplicación: $APK"
echo ""

find "$TMPDIR" -type f | while read -r file; do
  filetype=$(file "$file")
  filename=$(echo "$file" | sed "s|$TMPDIR/||")
  
  echo "Analizando: $filename ($filetype)"
  
  # Buscar en texto
  echo "$PATTERNS" | while read -r pattern; do
    [ -z "$pattern" ] && continue
    
    # Usar strings para binarios
    if echo "$filetype" | grep -q "text"; then
      matches=$(grep -E -o "$pattern" "$file" 2>/dev/null | sed 's/^/  /')
    else
      matches=$(strings "$file" | grep -E -o "$pattern" 2>/dev/null | sed 's/^/  /')
    fi
    
    if [ -n "$matches" ]; then
      echo "[!] Posible secreto (patrón: $pattern):"
      echo "$matches"
      echo "--------------------------------"
    fi
  done
done

# Limpieza
rm -rf "$TMPDIR"
echo ""
echo "Escaneo completado."
