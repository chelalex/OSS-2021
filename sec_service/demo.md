# Сервис мониторинга сеансов пользователей

Разработать сервис, который выполняет мониторинг подключённых к системе пользователей по ssh каждые 30 секунд. При подключении внешнего пользователя по ssh, пользователю должно выводиться на экран уведомление (механизм notify) с именем пользователя, который подключился к системе удалённо.

### Создание политики SELinux

1. Сгенерировать шаблон модуля политики SELinux: `sepolicy generate --init ssh_monitoring`

Будут созданы 5 файлов:

- Type Enforcing File ssh_monitoring.te;

- Interface File ssh_monitoring.if;

- File Context ssh_monitoring.fc;

- RPM Spec File ssh_monitoring_selinux.spec;

- Shell File ssh_monitoring.sh

2. Запустить скрипт ssh_monitoring.sh:
   `sudo ./ssh_monitoring.sh`

Будет создан модуль политики SELinux - файл `ssh_monitoring.pp`

3. Добавить политику в список системных модулей:
   `semodule -i ssh_monitoring.pp`

4. Изменить контекст безопасности (тип) сервиса :

`sudo chcon -t ssh_monitoring_exec_t /usr/bin/ssh-monitoring`

Посмотреть изменившийся контекст можно командой:

`ps -eZ | grep ssh_monitoring`

Вывод:

``system_u:system_r:ssh_monitoring_t:s0 427 ?   00:00:00 ssh_monitoring.``

5.  **Проверить** работу сервиса:

Подключиться к ssh от имени другого пользователя chelalex1 и переключиться обратно на chelalex, а затем посмотреть запись в файле `/var/log/messages`:

``июн  04 05:40:49 localhost systemd-logind: New session 69 of user chelalex1.``
``июн  04 05:40:49 localhost systemd: Started Session 69 of user chelalex1.``
``июн  04 05:41:09 localhost systemd: Started Session 70 of user chelalex.``
``июн  04 05:41:09 localhost systemd-logind: New session 70 of user chelalex.``

При появлении сообщений в файле `/var/log/messages` о необходимости создания дополнительных модулей политики, выполнить предложенные команды.

### Сборка RPM пакета и создание репозитория

1. `cd ~`
2. `rpmdev-setuptree`
3. `cd ~/rpmbuild/SOURCES`
4. `mkdir ssh-monitoring-lastver`
5. `cp ~/ssh_system_service/rpm_and_repo/rpmbuild/SOURCES/ssh-monitoring-lastver/* ./ssh-monitoring-lastver`
6. `tar -cvzf ssh-monitoring-lastver.tar.gz ssh-monitoring-lastver`
7. `cd ../SPECS`
8. `~/ssh_system_service/rpm_and_repo/rpmbuild/SPECS/ssh-monitoring-lastver.spec ./`
9. `rpmbuild --ba ssh-monitoring-lastver.spec`
10. `sudo rpm -addsign ~/rpmbuild/RPMS/noarch/ssh-monitoring-lastver-1.el7.noarch.rpm`
11. `sudo mkdir -p /var/www/html/ssh-monitoring`
12. `sudo cp ~/rpmbuild/RPMS/noarch/ssh-monitoring-lastver-1.el7.noarch.rpm /var/www/html/ssh-monitoring`
13. `sudo createrepo -v /var/www/html/ssh-monitoring`
14. `sudo mv ~/ssh_system_service/rpm_and_repo/rpmbuild/RPM-GPG-KEY-cheraten3 /var/www/html/gpg-key`
15. `sudo cp ~/ssh_system_service/rpm_and_repo/ssh-monitoring.repo /etc/yum.repos.d`


### Cоздание gpg ключа

1. `gpg --gen-key`

![](/OSS-2021/sec_service/images/01.jpg)

![](/OSS-2021/sec_service/images/02.jpg)

2. `gpg2 --export -a 'chelalex3' > ~/rpmbuild/RPM-GPG-KEY-chelalex3`

3. `vi ~/.rpmmacros`

![](/OSS-2021/sec_service/images/03.jpg)

4. `gpg --export --armor 7A36FC6D > /tmp/gpg-key`

5. `cp /tmp/gpg-key /var/www/html/`

### Демонстрация работы сервиса

1. `sudo yum install ssh-monitoring`
2. `sudo systemctl start ssh-monitoring`
3. **Дерево процессов**

`pstree`

![](/OSS-2021/sec_service/images/04.PNG)

4. `ps -eZ | grep ssh-monitoring`

Сервис работает в **собственном** домене.

![](/OSS-2021/sec_service/images/05.jpg)

5. `sudo systemctl restart ssh-monitoring`

![](/OSS-2021/sec_service/images/06.PNG)

6. `journalctl -f -u ssh-monitoring`

**Собственный журнал событий**. Ведутся записи о старте сервиса, его остановке, о выполнении основной функции.

![](/OSS-2021/sec_service/images/07.jpg)

**Запуск** сервиса (логирование запуска в `/var/log/messages`)

7. **Подключение** пользователя chelalex1 в систему по ssh

`ssh chelalex1@localhost`

**Запись** логов работы сервиса при подключении в `/var/log/messages` и запись о выполнении функции в журнале (см.пункт выше)

``июн  04 09:11:34 localhost root: > chelalex1 successfully login``
``июн  04 09:11:34 localhost wall[8608]: wall: user root broadcasted 1 line (32 chars)``
``июн  04 09:11:34 localhost ssh-monitoring.sh: > chelalex1 successfully login``

8. **Обработка** сигнала **USR1**:

`sudo kill -SIGUSR1 PID`


9. Демонстрация **man** страницы

![](/OSS-2021/sec_service/images/08.PNG)