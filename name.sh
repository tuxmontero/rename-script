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

