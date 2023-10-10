#include <stdio.h>
#include <string.h>

void success() { puts("Now you know what is ret2text."); }
int sys()
{
  system("/bin/sh");
}
void vulnerable()
{
  
  char s[12];
  gets(s);
  puts(s);
  return;
}

int main(int argc, char **argv)
{
  vulnerable();
  return 0;
}