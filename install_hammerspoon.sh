#!/bin/bash

# URL для скачивания архива
URL="https://github.com/Hammerspoon/hammerspoon/releases/download/1.0.0/Hammerspoon-1.0.0.zip"

# Имя файла архива
ZIP_FILE="Hammerspoon-1.0.0.zip"

# Папка для распаковки архива
EXTRACT_DIR="Hammerspoon-1.0.0"

# Папка Applications
APPLICATIONS_DIR="/Applications"

# Папка конфигурации Hammerspoon
HAMMERSPOON_CONFIG_DIR="$HOME/.hammerspoon"

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

# Копируем конфигурационные файлы и папку Spoons
echo "Копируем конфигурационные файлы и папку Spoons..."

# Проверяем и создаем папку конфигурации, если она не существует
mkdir -p "$HAMMERSPOON_CONFIG_DIR"

# Копируем init.lua
if [ -f "init.lua" ]; then
    if [ -f "$HAMMERSPOON_CONFIG_DIR/init.lua" ]; then
        echo "Создаем резервную копию существующего init.lua..."
        mv "$HAMMERSPOON_CONFIG_DIR/init.lua" "$HAMMERSPOON_CONFIG_DIR/init.lua.bkp"
    fi
    cp "init.lua" "$HAMMERSPOON_CONFIG_DIR/"
    echo "init.lua скопирован."
else
    echo "Файл init.lua не найден в текущей директории."
fi

# Копируем папку Spoons
if [ -d "Spoons" ]; then
    if [ -d "$HAMMERSPOON_CONFIG_DIR/Spoons" ]; then
        echo "Создаем резервную копию существующей папки Spoons..."
        mv "$HAMMERSPOON_CONFIG_DIR/Spoons" "$HAMMERSPOON_CONFIG_DIR/Spoons.bkp"
    fi
    cp -r "Spoons" "$HAMMERSPOON_CONFIG_DIR/"
    echo "Папка Spoons скопирована."
else
    echo "Папка Spoons не найдена в текущей директории."
fi

echo "Готово!"