#include <stdio.h>
#include <unistd.h>

int main(void)
{
  int pid = fork();
  // определить, в каком процессе мы находимся, помогает переменная pid

  sleep(3);
  return 0;
}

