#!/bin/bash

echo "Каталоги:"
if [[ $(ls -l | grep "^d" | wc -l) != "       0" ]]
then
	ls -l | grep "^d"
else
	echo "	каталогов нет =("
fi
echo "Обычные файлы:"
if [[ $(ls -l | grep "^-" | wc -l) != "       0" ]]
then
	ls -l | grep "^-"
else
	echo "	обычных файлов нет =("
fi
echo "Символьные ссылки:"
if [[ $(ls -l | grep "^l" | wc -l) != "       0" ]]
then
	ls -l | grep "^l"
else
	echo "	символьных ссылок нет =("
fi
echo "Символьные устройства:"
if [[ $(ls -l | grep "^c" | wc -l) != "       0" ]]
then
	ls -l | grep "^c"
else
	echo "	символьных устройств нет =("
fi
echo "Блочные устройства:"
if [[ $(ls -l | grep "^b" | wc -l) != "       0" ]]
then
	ls -l | grep "^b"
else
	echo "	блочных устройств нет =("
fi
