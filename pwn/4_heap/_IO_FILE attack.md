


# 结构体
## `_IO_FILE`

```c
struct _IO_FILE
{
  int _flags;       /* High-order word is _IO_MAGIC; rest is flags. */

  /* The following pointers correspond to the C++ streambuf protocol. */
  char *_IO_read_ptr;   /* Current read pointer */
  char *_IO_read_end;   /* End of get area. */
  char *_IO_read_base;  /* Start of putback+get area. */
  char *_IO_write_base; /* Start of put area. */
  char *_IO_write_ptr;  /* Current put pointer. */
  char *_IO_write_end;  /* End of put area. */
  char *_IO_buf_base;   /* Start of reserve area. */
  char *_IO_buf_end;    /* End of reserve area. */

  /* The following fields are used to support backing up and undo. */
  char *_IO_save_base; /* Pointer to start of non-current get area. */
  char *_IO_backup_base;  /* Pointer to first valid character of backup area */
  char *_IO_save_end; /* Pointer to end of non-current get area. */

  struct _IO_marker *_markers;

  struct _IO_FILE *_chain;

  int _fileno;
  // ...
};
```
标准库中的stdin,stdout,stderr都是FILE指针
其中struct _IO\_FILE *_chain 实现链表结构
-   `stdin->chain = 0`
-   `stdout->chain = &stdin`
-   `stderr->chain = &stdout`
全局头部 \_IO\_list\_all
```c
struct _IO_FILE_plus *_IO_list_all = &_IO_2_1_stderr_;
```
在使用fopen打开新的文件流时，会将创建的FILE结构体插入到链表头部



## `_IO_FILE_plus`
```c
struct _IO_FILE_plus
{
  _IO_FILE file;
  const struct _IO_jump_t *vtable;
};
```
`_IO_jump_t`是存储函数地址的虚函数表

## `_IO_jump_t`
```c
#define JUMP_FIELD(TYPE, NAME) TYPE NAME
struct _IO_jump_t
{
    JUMP_FIELD(size_t, __dummy);
    JUMP_FIELD(size_t, __dummy2);
    JUMP_FIELD(_IO_finish_t, __finish);
    JUMP_FIELD(_IO_overflow_t, __overflow);
    JUMP_FIELD(_IO_underflow_t, __underflow);
    JUMP_FIELD(_IO_underflow_t, __uflow);
    JUMP_FIELD(_IO_pbackfail_t, __pbackfail);
    /* showmany */
    JUMP_FIELD(_IO_xsputn_t, __xsputn);
    JUMP_FIELD(_IO_xsgetn_t, __xsgetn);
    JUMP_FIELD(_IO_seekoff_t, __seekoff);
    JUMP_FIELD(_IO_seekpos_t, __seekpos);
    JUMP_FIELD(_IO_setbuf_t, __setbuf);
    JUMP_FIELD(_IO_sync_t, __sync);
    JUMP_FIELD(_IO_doallocate_t, __doallocate);
    JUMP_FIELD(_IO_read_t, __read);
    JUMP_FIELD(_IO_write_t, __write);
    JUMP_FIELD(_IO_seek_t, __seek);
    JUMP_FIELD(_IO_close_t, __close);
    JUMP_FIELD(_IO_stat_t, __stat);
    JUMP_FIELD(_IO_showmanyc_t, __showmanyc);
    JUMP_FIELD(_IO_imbue_t, __imbue);
};
```

# 虚表劫持


进行IO操作时，会触发虚表中的函数
![[Pasted image 20230424172521.png]]
两种劫持方式
* 直接改写 vtable 中的函数指针，通过任意地址写就可以实现。
* 覆盖 vtable 的指针指向我们控制的内存，然后在其中布置函数指针。

## glibc2.23 虚表劫持
### demo
```c
#include <stdio.h>
#include <stdlib.h>

void pwn(void)
{
    printf("Dave, my mind is going.\n");
    fflush(stdout);
}

void * funcs[] = {
    NULL, // "extra word"
    NULL, // DUMMY
    exit, // finish
    NULL, // overflow
    NULL, // underflow
    NULL, // uflow
    NULL, // pbackfail
    NULL, // xsputn
    NULL, // xsgetn
    NULL, // seekoff
    NULL, // seekpos
    NULL, // setbuf
    NULL, // sync
    NULL, // doallocate
    NULL, // read
    NULL, // write
    NULL, // seek
    pwn,  // close
    NULL, // stat
    NULL, // showmanyc
    NULL, // imbue
};

int main(int argc, char * argv[])
{   
    FILE *fp;
    unsigned char *str;
    //申请_IO_FILE_plus结构体的大小的堆空间
    str = malloc(sizeof(FILE) + sizeof(void *));
    free(str);

    if (!(fp = fopen("/dev/null", "r"))) {
        perror("fopen");
        return 1;
    }
	//修改虚表
    *(unsigned long*)(str + sizeof(FILE)) = (unsigned long)funcs;
	//会触发虚表中的close函数
    fclose(fp);
    return 0;
}
```

## FSOP
`_IO_list_all`指针
没有涉及到文件操作时
```
_IO_list_all -> stderr，stderr._chain -> stdout，stdout._chain -> stdin
```
攻击思路：
伪造一块`_IO_FILE_plus`结构体替换原本的节点，在利用漏洞修改_IO_list_all的值为可控内存区域。
之后通过_IO_flush_all_lockp函数。刷新链表中的文件流，对每个FILE调用fflush，对应vtable中的_IO_overflow.
```c
int  
_IO_flush_all_lockp (int do_lock)  
{  
  ...  
  fp = (_IO_FILE *) _IO_list_all;  
  while (fp != NULL)  
  {  
       ...  
       if (((fp->_mode <= 0 && fp->_IO_write_ptr > fp->_IO_write_base))  
               && _IO_OVERFLOW (fp, EOF) == EOF)	// 判断缓冲区是否有数据，有则刷新  
           {  
               result = EOF;  
          }  
        ...  
  }  
}
```
在如下情况时，这个函数会被系统调用
1.  libc执行abort时
2.  执行exit函数时
3.  main函数返回时（执行了exit函数）


## glibc 2.24保护
GLIBC 维护了多张虚表，但这些虚表均处于一段较为固定的内存，因此该判断触发条件是，虚表不位于该内存段处。

```c
IO_validate_vtable (const struct _IO_jump_t *vtable)
{
  /* Fast path: The vtable pointer is within the __libc_IO_vtables
     section.  */
  uintptr_t section_length = __stop___libc_IO_vtables - __start___libc_IO_vtables;
  const char *ptr = (const char *) vtable;
  uintptr_t offset = ptr - __start___libc_IO_vtables;
  if (__glibc_unlikely (offset >= section_length))
    /* The vtable pointer is not in the expected section.  Use the
       slow path, which will terminate the process if necessary.  */
    _IO_vtable_check ();
  return vtable;
}
```

### 修改 \_IO_buf_base
\_IO_buf_base 表示对FILE结构体进行IO操作时的堆地址，修改该地址可以实现任意地址读写


例子
```c
#include "stdio.h"

char buf[100];

int main()
{
 char stack_buf[100];
 scanf("%s",stack_buf);
 scanf("%s",stack_buf);
}
```
第一次调用scanf,\_IO_2_1_stdin是空的

```c
b __isoc99_scanf


gef➤  p _IO_2_1_stdin_
$4 = {
  file = {
    _flags = 0xfbad2088, 
    _IO_read_ptr = 0x0, 
    _IO_read_end = 0x0, 
    _IO_read_base = 0x0, 
    _IO_write_base = 0x0, 
    _IO_write_ptr = 0x0, 
    _IO_write_end = 0x0, 
    _IO_buf_base = 0x0, 
    _IO_buf_end = 0x0, 
    _IO_save_base = 0x0, 
    _IO_backup_base = 0x0, 
    _IO_save_end = 0x0, 
    _markers = 0x0, 
    _chain = 0x0, 
    _fileno = 0x0, 
    _flags2 = 0x0, 
    _old_offset = 0xffffffffffffffff, 
    _cur_column = 0x0, 
    _vtable_offset = 0x0, 
    _shortbuf = "", 
    _lock = 0x7ffff7dcf8d0 <_IO_stdfile_0_lock>, 
    _offset = 0xffffffffffffffff, 
    _codecvt = 0x0, 
    _wide_data = 0x7ffff7dcdae0 <_IO_wide_data_0>, 
    _freeres_list = 0x0, 
    _freeres_buf = 0x0, 
    __pad5 = 0x0, 
    _mode = 0x0, 
    _unused2 = '\000' <repeats 19 times>
  }, 
  vtable = 0x7ffff7dca2a0 <_IO_file_jumps>
}
```
第二次调用,\_IO_2_1_stdin_ 填充了上次调用输入的数据
```c
gef➤  p _IO_2_1_stdin_
$6 = {
  file = {
    _flags = 0xfbad2288, 
    _IO_read_ptr = 0x555555756269 "\n", 
    _IO_read_end = 0x55555575626a "", 
    _IO_read_base = 0x555555756260 "abcasdasf\n", 
    _IO_write_base = 0x555555756260 "abcasdasf\n", 
    _IO_write_ptr = 0x555555756260 "abcasdasf\n", 
    _IO_write_end = 0x555555756260 "abcasdasf\n", 
    _IO_buf_base = 0x555555756260 "abcasdasf\n", 
    _IO_buf_end = 0x555555756660 "", 
    _IO_save_base = 0x0, 
    _IO_backup_base = 0x0, 
    _IO_save_end = 0x0, 
    _markers = 0x0, 
    _chain = 0x0, 
    _fileno = 0x0, 
    _flags2 = 0x0, 
    _old_offset = 0xffffffffffffffff, 
    _cur_column = 0x0, 
    _vtable_offset = 0x0, 
    _shortbuf = "", 
    _lock = 0x7ffff7dcf8d0 <_IO_stdfile_0_lock>, 
    _offset = 0xffffffffffffffff, 
    _codecvt = 0x0, 
    _wide_data = 0x7ffff7dcdae0 <_IO_wide_data_0>, 
    _freeres_list = 0x0, 
    _freeres_buf = 0x0, 
    __pad5 = 0x0, 
    _mode = 0xffffffff, 
    _unused2 = '\000' <repeats 19 times>
  }, 
  vtable = 0x7ffff7dca2a0 <_IO_file_jumps>
}

```



### 修改FILE结构体中的字段
#### fwrite
将fileno修改为1，在触发系统调用时，将数据返回
```c
int
_IO_new_file_overflow (FILE *f, int ch) {
  /* If currently reading or no buffer allocated. */
  if ((f->_flags & _IO_CURRENTLY_PUTTING) == 0 || f->_IO_write_base == NULL) {
    // ...
  }
  if (ch == EOF)
    return _IO_do_write (f, f->_IO_write_base,
             f->_IO_write_ptr - f->_IO_write_base);
  if (f->_IO_write_ptr == f->_IO_buf_end ) /* Buffer is really full */
    if (_IO_do_flush (f) == EOF)
      return EOF;
  // ...
}
```

`_IO_do_write`将write_base至write_ptr之间的数据写入到fp中，因此将其修改为目标区间，即可读取任意地址的信息。
修改字段：
```
-   `_fileno` 设为 1；
-   `_flag &= ~_IO_NO_WRITES`，清除掉读字段，只需要往目标文件写内容；
-   `_flag |= _IO_CURRENTLY_PUTTING`；添加该字段，绕过 overflow 的条件判断；
-   设置 `_IO_write_base` 为想要泄露的起始地址，`_IO_write_ptr` 为结束地址；
-   设置 `_IO_read_end` = `_IO_write_base`； 防止do_write时seek扰乱内存
```

#### fread
将_fileno改为0，输入的
```c
size_t _IO_file_xsgetn (FILE *fp, void *data, size_t n) {
    // while (want > 0)
    have = fp->_IO_read_end - fp->_IO_read_ptr;
    if (want <= have) {
        // 直接拷贝缓存到目标地址
    } else {
        // ...
        if (fp->_IO_buf_base
          && want < (size_t) (fp->_IO_buf_end - fp->_IO_buf_base))
        {
          if (__underflow (fp) == EOF)
        break;

          continue;
        }
    }
}

int _IO_new_file_underflow (FILE *fp) {
    // ...
    if (fp->_flags & _IO_EOF_SEEN) return EOF;
    if (fp->_flags & _IO_NO_READS) return EOF;
    if (fp->_IO_read_ptr < fp->_IO_read_end)
        return *(unsigned char *) fp->_IO_read_ptr;
    // ...
    count = _IO_SYSREAD (fp, fp->_IO_buf_base,
            fp->_IO_buf_end - fp->_IO_buf_base);
}
```

修改字段：
-   设置 `_fileno` 为 0(标准输入)；
-   设置 `_flag &= ~_IO_NO_READS`，绕过 underflow 中的判断；
-   设置 buf_base 和 buf_end 分别为要写入的目标起始和结束地址，即手动指定缓存。注意写入的大小要小于该缓存大小，否则缓存会被刷到 data 中导致写入数据混乱；
-   设置 read_base = read_ptr = NULL，这也是初次申请完缓存后 `_IO_default_setbuf` 设置的默认值；


# House of apple1
# House of Orange


