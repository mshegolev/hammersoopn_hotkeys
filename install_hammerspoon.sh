#!/bin/bash

# URL для скачивания архива
URL="https://github.com/Hammerspoon/hammerspoon/releases/download/1.0.0/Hammerspoon-1.0.0.zip"

# Имя файла архива
ZIP_FILE="Hammerspoon-1.0.0.zip"

# Папка для распаковки архива
EXTRACT_DIR="Hammerspoon-1.0.0"

# Папка Applications
APPLICATIONS_DIR="/Applications"

# Скачиваем архив
echo "Скачиваем архив..."
curl -L -o "$ZIP_FILE" "$URL"

# Проверяем, успешно ли скачался архив
if [ ! -f "$ZIP_FILE" ]; then
    echo "Ошибка: не удалось скачать архив."
    exit 1
fi

# Распаковываем архив
echo "Распаковываем архив..."
unzip "$ZIP_FILE"

# Проверяем, успешно ли распаковался архив
if [ ! -d "$EXTRACT_DIR" ]; then
    echo "Ошибка: не удалось распаковать архив."
    exit 1
fi

# Перемещаем распакованное приложение в папку Applications
echo "Копируем приложение в папку Applications..."
mv "$EXTRACT_DIR" "$APPLICATIONS_DIR/"

# Проверяем, успешно ли скопировалось приложение
if [ ! -d "$APPLICATIONS_DIR/$EXTRACT_DIR" ]; then
    echo "Ошибка: не удалось скопировать приложение в папку Applications."
    exit 1
fi

# Удаляем скачанный архив
echo "Удаляем скачанный архив..."
rm "$ZIP_FILE"

echo "Готово!"