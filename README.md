# Script para Renombrar y Mover Subtítulos de Series

Este script en Bash automatiza la tarea de renombrar archivos de subtítulos `.srt` según el nombre del episodio correspondiente de una serie y moverlos al directorio donde está el archivo de video. Es especialmente útil cuando trabajas con directorios estructurados que contienen subtítulos en múltiples idiomas.

## Caso de Uso

Tienes un directorio que contiene los archivos de video `.mp4` de una serie, y un subdirectorio llamado `Subs` que contiene carpetas con el mismo nombre de cada archivo `.mp4` (pero sin la extensión). Dentro de estas carpetas hay subtítulos en varios idiomas con nombres no descriptivos, como:

```
1000_en-US.srt   1005_es-419.srt  1016_nl-NL.srt
1007_es-ES.srt   1009_fi-FI.srt   1020_pt-PT.srt
```

El objetivo es seleccionar subtítulos en tres idiomas específicos (español, inglés y neerlandés) y renombrarlos según el archivo de video, agregando el código del idioma antes de la extensión `.srt`. Luego, los subtítulos renombrados deben moverse al directorio principal donde están los archivos de video.

### Ejemplo

#### Antes:
Directorio:
```
Game.of.Thrones.S03E07.1080p.BluRay.x265-RARBG.mp4
Subs/
    Game.of.Thrones.S03E07.1080p.BluRay.x265-RARBG/
        1007_es-ES.srt
        1000_en-US.srt
        1016_nl-NL.srt
```

#### Después:
Directorio:
```
Game.of.Thrones.S03E07.1080p.BluRay.x265-RARBG.mp4
Game.of.Thrones.S03E07.1080p.BluRay.x265-RARBG.es.srt
Game.of.Thrones.S03E07.1080p.BluRay.x265-RARBG.en.srt
Game.of.Thrones.S03E07.1080p.BluRay.x265-RARBG.nl.srt
Subs/
    Game.of.Thrones.S03E07.1080p.BluRay.x265-RARBG/
        (archivos restantes si los hay)
```

## Cómo Funciona

El script:
1. Identifica todos los archivos `.mp4` en el directorio principal.
2. Entra en el subdirectorio correspondiente dentro de `Subs`.
3. Busca los subtítulos en los idiomas específicos (`es`, `en`, `nl`).
4. Renombra los archivos `.srt` usando el nombre del archivo de video, con el código del idioma añadido antes de la extensión.
5. Mueve los archivos renombrados al directorio principal.

## Uso

### Requisitos
- Bash (generalmente disponible en sistemas Unix/Linux y macOS).
- Directorio estructurado como se describe.

### Ejecución
1. Clona este repositorio o descarga el archivo del script.
2. Asegúrate de que el script tenga permisos de ejecución:
   ```bash
   chmod +x renombrar_subtitulos.sh
   ```
3. Coloca el script en el mismo directorio donde están los archivos `.mp4`.
4. Ejecuta el script:
   ```bash
   ./renombrar_subtitulos.sh
   ```

### Configuración
El script viene preconfigurado para buscar los idiomas:
- Español (`es`)
- Inglés (`en`)
- Neerlandés (`nl`)

Si necesitas agregar o cambiar idiomas, edita la línea del script:
```bash
for lang in "es" "en" "nl"; do
```

## Código del Script

```bash
#!/bin/bash

# Directorio actual donde se encuentran los .mp4
BASE_DIR=$(pwd)

# Iterar sobre los archivos .mp4 en el directorio base
for video_file in *.mp4; do
    # Obtener el nombre base del archivo sin la extensión
    base_name="${video_file%.mp4}"

    # Construir la ruta al subdirectorio correspondiente en Subs
    subs_dir="$BASE_DIR/Subs/$base_name"

    # Verificar si el subdirectorio de subtítulos existe
    if [ -d "$subs_dir" ]; then
        echo "Procesando subtítulos en: $subs_dir"

        # Iterar sobre los idiomas de interés
        for lang in "es" "en" "nl"; do
            # Buscar el archivo correspondiente al idioma
            srt_file=$(find "$subs_dir" -type f -name "*_${lang}-??.srt" | head -n 1)

            # Si se encuentra el archivo, renombrarlo y moverlo
            if [ -n "$srt_file" ]; then
                new_name="${base_name}.${lang}.srt"
                echo "Renombrando $srt_file a $BASE_DIR/$new_name"
                mv "$srt_file" "$BASE_DIR/$new_name"
            else
                echo "Subtítulo para idioma $lang no encontrado en $subs_dir"
            fi
        done
    else
        echo "Directorio de subtítulos no encontrado: $subs_dir"
    fi
done

echo "Renombrado y movimiento de subtítulos completado."
```

## Notas
- El script es sensible a la estructura del directorio. Asegúrate de que los archivos `.mp4` y el subdirectorio `Subs` estén organizados como se describe.
- Puedes personalizar los idiomas o ajustar los patrones de búsqueda según tus necesidades.

## Licencia

Este script se proporciona bajo la licencia MIT. Siéntete libre de usarlo, modificarlo y compartirlo.
