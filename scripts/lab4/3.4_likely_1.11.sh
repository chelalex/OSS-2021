#!/bin/bash
echo "Каталоги:"
if [[ $(ls -l "$1"| grep "^d" | wc -l) != "       0" ]]
then
        ls -l "$1"| grep "^d"
else
        echo "  каталогов нет =("
fi
echo "Обычные файлы:"
if [[ $(ls -l "$1"| grep "^-" | wc -l) != "       0" ]]
then
        ls -l "$1"| grep "^-"
else
        echo "  обычных файлов нет =("
fi
echo "Символьные ссылки:"
if [[ $(ls -l "$1"| grep "^l" | wc -l) != "       0" ]]
then
        ls -l "$1"| grep "^l"
else
        echo "  символьных ссылок нет =("
fi
echo "Символьные устройства:"
if [[ $(ls -l "$1"| grep "^c" | wc -l) != "       0" ]]
then
        ls -l "$1"| grep "^c"
else
        echo "  символьных устройств нет =("
fi
echo "Блочные устройства:"
if [[ $(ls -l "$1"| grep "^b" | wc -l) != "       0" ]]
then
        ls -l "$1"| grep "^b"
else
        echo "  блочных устройств нет =("
fi
