#include <stdio.h>

extern char **environ;
int main(int argc, char *argv[])
{
  char **p;
  unsigned int count = 0;
  for (p = environ; *p != NULL; p++) /* перебор всех элементов массива */
    count++;
  printf("Number of environment variables: %u\nNumber of arguments: %d\n", count, argc);
}
