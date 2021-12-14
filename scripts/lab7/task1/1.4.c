#include <stdio.h>

extern char **environ;
int main(int argc, char *argv[])
{
  if (argc < 2) {
  	printf("No number of environment variables!\n");
	return -1;
  }
  char **p;
  int MAX = atoi(argv[1]);
  int count = 0;
  for (p = environ; *p != NULL && count < MAX; p++, count++) /* перебор всех элементов массива */
    printf("%s\n", *p); /* разыменование указателя */
}

