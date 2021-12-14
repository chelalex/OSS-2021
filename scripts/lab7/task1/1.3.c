#include <stdio.h>

extern char **environ;
int main(int argc, char *argv[])
{
  char **p;
  const int MAX = 10;
  int count = 0;
  for (p = environ; *p != NULL && count < MAX; p++, count++) /* перебор всех элементов массива */
    printf("%s\n", *p); /* разыменование указателя */
}
