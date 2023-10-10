[toc]

# Dll注入

## 加载DLL时机
1. 进程创建阶段加载输入表中DLL
2. 通过调用LoadLibrary主动加载DLL 动态加载
3. 系统机制的要求，加载系统预设基础服务模块

### 进程创建阶段加载输入表中DLL

进程被创建不会直接先从程序入口处执行，首先被执行的是ntdll.dll中的LdrInitializeThunk函数

#### 1.静态修改PE输入表


#### 2.进程创建期修改PE输入表

#### 3.输入表项DLL替换


### 改变程序运行流程使主动加载目标DLL
#### 1.CreateRemoteThread
#### 2.RtlCreateUserThread
#### 3.QueueUserApc/NtQueueApcThread APC注入
#### 4.SetThreadContext
#### 5.内核通过Hook/Notify干预执行流程法
#### 6.内核KeUserModeCallback
#### 7.纯WriteProcessMemory




### 系统机制的要求，加载系统预设基础服务模块（shell扩展，网络服务接口，输入法等）
#### 1.SetWindowHookEx消息钩子
#### 2.AppInit_DLLs注册表
#### 3.输入法注入
#### 4.SPI网络过滤注入
#### 5.ShimEngine注入
#### 6.Explorer Shell扩展注入


## DLL注入应用
### 1.内存补丁
### 2.增强PEDIY
### 3.与Hook技术结合

## DLL注入防范
### 驱动层防范
#### 1.KeUserModeCallback防全局消息钩子注入
#### 2.NtMapViewOfSection/LoadImageNotify对模块进行验证
#### 3.拦截进程打开读写以及创建远线程 发送APC等操作
#### 4.Call Stack检测非法模块
### 应用层防范
#### 1. 通过HookLoadLibraryEx函数防范全局钩子 输入法注入
#### 2. 在DllMain中防御远程线程
#### 3. 枚举并查找当前进程中非法模块和可疑内存
#### 4. Hook ntdll中的底层函数进行Call Stack检测


## Detours的API钩子库

http://research.microsoft.com/en-us/projects/detours/

api钩子两种类型

1.改写函数开头几个字节
2.改写IAT（Import Address Table，导入地址表）





Detours: Binary Interception of Win32 Functionshttp://research.microsoft.com/pubs/68568/huntusenixnt99.pdf



钩子的原理是将函数开头的几个字节替换成jmp指令，强制跳转到另一个函数