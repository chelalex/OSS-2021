* Что происходит при прерывании скрипта text-trap.sh? Объясните, почему.
	```
	SIGINT есть signal interrupt, который мы посылаем с помощью Ctrl+С, поэтому срабатывает trap
	```
* Напишите, по какой причине выводы команды `ls -l /proc/self` и `ls -l /proc/$$` отличаются?
	```sh
	ls -l /proc/self # self относится к pid ls
    ls -l /proc/$$ # $$ относится к pid shell
	```
* Напишите, какие дескрипторы в выводе команды `ls -l /proc/self/fd` отвечают за stdin, stdout, stderr.
	```
     0 отвечает за stdin
     1 отвечает за stdout
     2 отвечает за stderr
	```
* Что происходит с дескрипторами при перенаправлении потоков stdout и stderr в файлы при выполнении команды `ls -l /proc/self/fd > /tmp/ls.out 2> /tmp/ls.err`?
	```
	Они соответственно меняются на /tmp/ls.out и /tmp/ls.err
	```
* Запишите эту же команду, добавив к ней перенаправление потока stdin. Что изменилось?
	```
	Если входного файла нет, то будет ошибка в /tmp/ls.err.
	Иначе в /tmp/ls.out будет листинг директории /proc/self/fd
	```
* Какой эффект наблюдается при выполнении команды `exec ps -l`?
	```
	Закрывается текущее окно терминала, так как успешно выполнилась команда exec
	```
* Что означает `pos` при выводе содержимого файла `/proc/$$/fdinfo/3`?
	```
	Это смещение внутри файла (14 == len("Test3\nTest333\n"))
	```
* Существует ли возможность читать содержимое файла test.out даже после его удаления? Почему так происходит?
	```
	Нет, при cat test.out ошибка, нет такого файла.
	При cat <&4 - ничего
	```