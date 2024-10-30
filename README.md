# Тестовый проект для изучения работы с OMNIBUS

## Установка

Здесь приводится список команд для установки `Omnibus` на дистрибутив `Fedora 40`.

Требования:
- `Ruby 2.6+`

Установим `CRuby`:

```sh
sudo dnf install ruby
```

После установки в системе появится command-line утилита `gem`

Для установки `Omnibus` следует воспользоваться ей.

`Omnibus` устанавливается при помощи следующей команды:
```sh
gem install omnibus
```

В системе появится command-line утилита omnibus.

В моём случае установка omnibus завершилась ошибкой и потребовалось установить `ruby development environment`.

В `Fedora 40` сделать это можно выполнив следующую команду:
```sh
sudo dnf install ruby-devel
```

Повторная попытка установки omnibus также неудалась, но уже с другой ошибкой.
В логах следующий текст:
```txt
pkg_config: checking for pkg-config for libffi... -------------------- not found

LD_LIBRARY_PATH=.:/usr/lib64 x86_64-redhat-linux-gnu-pkg-config --exists libffi
package configuration for libffi is not found
--------------------

LD_LIBRARY_PATH=.:/usr/lib64 "gcc -o conftest -I/usr/include -I/usr/include/ruby/backward -I/usr/include -I.    -O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -fPIC conftest.c  -L. -L/usr/lib64 -L. -Wl,-z,relro -Wl,--as-needed  -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -Wl,--build-id=sha1 -fstack-protector-strong -rdynamic -Wl,-export-dynamic -Wl,--no-as-needed  -m64   -lruby  -lm -lpthread  -lc"
checked program was:
/* begin */
1: #include "ruby.h"
2: 
3: int main(int argc, char **argv)
4: {
5:   return !!argv[argc];
6: }
/* end */
```

Поэтому попытался установить недостающую библиотеку libffi (сразу девелоперский пакет):

```sh
sudo dnf install libffi-devel
```

После, попытался снова установить omnibus. Однако снова неудача, в логах:

```
LD_LIBRARY_PATH=.:/usr/lib64 x86_64-redhat-linux-gnu-pkg-config --exists libffi
LD_LIBRARY_PATH=.:/usr/lib64 x86_64-redhat-linux-gnu-pkg-config --libs libffi |
=> "-L/usr/lib64/../lib64 -lffi\n"
LD_LIBRARY_PATH=.:/usr/lib64 "gcc -o conftest -I/usr/include -I/usr/include/ruby/backward -I/usr/include -I.    -O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -fPIC conftest.c  -L. -L/usr/lib64 -L. -Wl,-z,relro -Wl,--as-needed  -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -Wl,--build-id=sha1 -fstack-protector-strong -rdynamic -Wl,-export-dynamic -Wl,--no-as-needed  -m64   -lruby  -lm -lpthread  -lc"
checked program was:
/* begin */
1: #include "ruby.h"
2: 
3: int main(int argc, char **argv)
4: {
5:   return !!argv[argc];
6: }
/* end */

```

После разбирательств, оказалось, что необходимо установить gcc:

```sh
sudo dnf install gcc
```