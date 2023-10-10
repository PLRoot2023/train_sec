cd /data/icg/system/
rm -rf  /data/icg/codeql_db/sys/selfdefense_db
#/system/-app/selfdefense/build/make.sh
/opt/codeql/codeql/codeql database create  /data/icg/codeql_db/sys/selfdefense_db --language=cpp --source-root  /data/icg/system/  --command='sh app/selfdefense/build/make.sh'







cd /data/icg/system/
# /system/-um/build/spec/make.sh  
# error: failed to stat /data/icg/system/ns_um_icg9.0.spec: No such file or director   cannot stat `RPMS/x86_64/*': No such file or directory
/opt/codeql/codeql/codeql database create  /data/icg/codeql_db/sys/um_db --language=cpp --source-root  /data/icg/system/  --command='sh um/build/spec/make.sh'


# /system/-app/ssc/build/make.sh 
# 空
/opt/codeql/codeql/codeql database create  /data/icg/codeql_db/sys/ssc_db --language=cpp --source-root  /data/icg/system/  --command='sh app/ssc/build/make.sh'


# /system/-app/smc/make.sh
# 空
/opt/codeql/codeql/codeql database create  /data/icg/codeql_db/sys/smc_db --language=cpp --source-root  /data/icg/system/  --command='sh app/smc/make.sh'

# /system/-app/sort_nic/build/make.sh
# /root/kernel_source/el6/2.6.32-358.NSOS10.1.1.x86_64/: No such file or directory.
/opt/codeql/codeql/codeql database create  /data/icg/codeql_db/sys/sort_nic_db --language=cpp --source-root  /data/icg/system/  --command='sh app/sort_nic/build/make.sh'



# /system/-app/natdetect/build/make.sh
/opt/codeql/codeql/codeql database create  /data/icg/codeql_db/sys/natdetect_db --language=cpp --source-root  /data/icg/system/app/natdetect/build/  --command='sh make.sh'

# /system/-app/openc2soc/build/make.sh
/opt/codeql/codeql/codeql database create  /data/icg/codeql_db/sys/openc2soc_db --language=cpp --source-root  /data/icg/system/app/openc2soc/build/  --command='sh make.sh'


# /system/-app/breach_host_detection/build/make.sh
/opt/codeql/codeql/codeql database create  /data/icg/codeql_db/sys/breach_host_detection_db --language=cpp --source-root /data/icg/system/app/breach_host_detection/build/  --command='sh make.sh'


# /system/-system/build/make.sh
## system???????????
/opt/codeql/codeql/codeql database create  /data/icg/codeql_db/sys/system_db --language=cpp --source-root /data/icg/system/system/build/ --command='sh smake.sh'


# /system/-app/log_engine/build/make.sh
# [2023-05-04 16:23:36] [build-err] mdb.c: In function ‘mdb_env_cwalk’:
# [2023-05-04 16:23:36] [build-err] mdb.c:10052: warning: missing initializer
# [2023-05-04 16:23:36] [build-err] mdb.c:10052: warning: (near initialization for ‘mc.mc_backup’)
# [2023-05-04 16:23:36] [build-err] mdb.c: In function ‘mdb_env_copyfd1’:
# [2023-05-04 16:23:36] [build-err] mdb.c:10211: warning: missing initializer
# [2023-05-04 16:23:36] [build-err] mdb.c:10211: warning: (near initialization for ‘my.mc_txn’)
# [2023-05-04 16:23:38] [build] gcc -pthread -O0 -g -W -Wall -Wno-unused-parameter -Wbad-function-cast -Wuninitialized   -c midl.c
# [2023-05-04 16:23:38] [build] ar rs liblmdb.a mdb.o midl.o
# [2023-05-04 16:23:38] [build-err] /usr/bin/ar: creating liblmdb.a
# [2023-05-04 16:23:38] [build] gcc -pthread -O0 -g -W -Wall -Wno-unused-parameter -Wbad-function-cast -Wuninitialized  -fPIC  -c mdb.c -o md
# b.lo
# [2023-05-04 16:23:38] [build-err] mdb.c: In function ‘mdb_env_cwalk’:
# [2023-05-04 16:23:38] [build-err] mdb.c:10052: warning: missing initializer
# [2023-05-04 16:23:38] [build-err] mdb.c:10052: warning: (near initialization for ‘mc.mc_backup’)
# [2023-05-04 16:23:38] [build-err] mdb.c: In function ‘mdb_env_copyfd1’:
# [2023-05-04 16:23:38] [build-err] mdb.c:10211: warning: missing initializer
# [2023-05-04 16:23:38] [build-err] mdb.c:10211: warning: (near initialization for ‘my.mc_txn’)
/opt/codeql/codeql/codeql database create /data/icg/codeql_db/sys/log_engine_db --language=cpp --source-root /data/icg/system/app/log_engine/build/ --command='sh make.sh'


# /system/-app/singleuserdetection/build/make.sh
/opt/codeql/codeql/codeql database create /data/icg/codeql_db/sys/singleuserdetection_db --language=cpp --source-root /data/icg/system/app/singleuserdetection/build/ --command='sh make.sh'

# /system/-app/lanbypass/build/make.sh
/opt/codeql/codeql/codeql database create /data/icg/codeql_db/sys/lanbypass_db --language=cpp --source-root /data/icg/system/app/lanbypass/build/ --command='sh make.sh'

# /system/-tools/build/make.sh
/opt/codeql/codeql/codeql database create /data/icg/codeql_db/sys/tools_db --language=cpp --source-root /data/icg/system/tools/build/ --command='sh make.sh'


# /system/-app/nsproxy/build/make.sh
# [2023-05-04 16:39:57] [build-err] proxy_log.c:6:23: error: netentsec.h: No such file or directory
# [2023-05-04 16:39:57] [build-err] proxy_log.c:7:23: error: ring/ring.h: No such file or directory
# [2023-05-04 16:39:57] [build-err] proxy_log.c:8:33: error: proxy/proxy_context.h: No such file or directory
# [2023-05-04 16:39:57] [build-err] proxy_log.c:9:29: error: proxy/proxy_log.h: No such file or directory
# [2023-05-04 16:39:57] [build-err] proxy_log.c:11:21: error: pd_ring.h: No such file or directory
# [2023-05-04 16:39:57] [build-err] proxy_log.c:13: error: variable ‘netproxy_log_ring_type’ has initializer but incomplete type
# [2023-05-04 16:39:57] [build-err] proxy_log.c:15: error: unknown field ‘type’ specified in initializer
# [2023-05-04 16:39:57] [build-err] proxy_log.c:15: error: extra brace group at end of initializer
# [2023-05-04 16:39:57] [build-err] proxy_log.c:15: error: (near initialization for ‘netproxy_log_ring_type’)
# [2023-05-04 16:39:57] [build-err] proxy_log.c:15: error: ‘PROXY_LOG_RING_TYPE’ undeclared here (not in a function)
# [2023-05-04 16:39:57] [build-err] proxy_log.c:15: warning: excess elements in struct initializer
# [2023-05-04 16:39:57] [build-err] proxy_log.c:15: warning: (near initialization for ‘netproxy_log_ring_type’)
# [2023-05-04 16:39:57] [build-err] proxy_log.c:16: error: unknown field ‘name’ specified in initializer
# [2023-05-04 16:39:57] [build-err] proxy_log.c:17: warning: excess elements in struct initializer
# [2023-05-04 16:39:57] [build-err] proxy_log.c:17: warning: (near initialization for ‘netproxy_log_ring_type’)
# [2023-05-04 16:39:57] [build-err] proxy_log.c:19: error: ‘PROXY_CONN_STAT_MAX’ undeclared here (not in a function)
# [2023-05-04 16:39:57] [build-err] proxy_log.c:28: warning: ‘struct nf_conn’ declared inside parameter list
# [2023-05-04 16:39:57] [build-err] proxy_log.c:28: warning: its scope is only this definition or declaration, which is probably not what yo
/opt/codeql/codeql/codeql database create /data/icg/codeql_db/sys/nsproxy_db --language=cpp --source-root /data/icg/system/app/nsproxy/build/ --command='sh make.sh'

# /system/-app/net-snmp-5.9.1/build/make.sh
/opt/codeql/codeql/codeql database create /data/icg/codeql_db/sys/net-snmp_db --language=cpp --source-root /data/icg/system/app/net-snmp-5.9.1/build/ --command='sh make.sh'

# /system/-app/restricted-shell/build/make.sh
# 无cmake
/opt/codeql/codeql/codeql database create /data/icg/codeql_db/sys/restricted-shell_db --language=cpp --source-root /data/icg/system/app/restricted-shell/build/ --command='sh make.sh'

# /system/-app/race/build/make.sh
# 空的
/opt/codeql/codeql/codeql database create /data/icg/codeql_db/sys/race_db --language=cpp --source-root /data/icg/system/app/race/build/ --command='sh make.sh'


# /system/-app/ips/build/make.sh
# 空的
/opt/codeql/codeql/codeql database create /data/icg/codeql_db/sys/ips_db --language=cpp --source-root /data/icg/system/app/ips/build/ --command='sh make.sh'

# /system/-app/dpi/build/make.sh
# 空的
/opt/codeql/codeql/codeql database create /data/icg/codeql_db/sys/dpi_db --language=cpp --source-root /data/icg/system/app/dpi/build/ --command='sh make.sh'

# /system/-app/ns_account/build/make.sh
#  proxy_log.cpp:23:22: error: packuser.h: No such file or directory
/opt/codeql/codeql/codeql database create /data/icg/codeql_db/sys/ns_account_db --language=cpp --source-root /data/icg/system/app/ns_account/build/ --command='sh make.sh'


# /system/-app/ha/build/make.sh
#ild/make.sh: line 14: cd: /data/icg/system/app/ha/../ha_tunnel: No such file or directory
/opt/codeql/codeql/codeql database create /data/icg/codeql_db/sys/ha_db --language=cpp --source-root /data/icg/system/app/ha/ --command='sh build/make.sh'

# /system/-config_and_scripts/build/make.sh
# 非make 



# /system/-app/monitor_src/build/make.sh
# [build-err] get_userinfo.h:3:22: error: packuser.h: No such file or directory
# [2023-05-04 17:06:52] [build-err] server.cpp:38:22: error: log_api.h: No such file or directory
# [2023-05-04 17:06:52] [build-err] server.cpp:39:20: error: log_io.h: No such file or directory
# [2023-05-04 17:06:53] [build-err] In file included from server.cpp:36:
# [2023-05-04 17:06:53] [build-err] get_userinfo.h:23: error: ‘UM_PolicyInfo’ has not been declared
# [2023-05-04 17:06:53] [build-err] get_userinfo.h:24: error: ‘UM_UserInfo’ has not been declared
# [2023-05-04 17:06:53] [build-err] get_userinfo.h:27: error: ISO C++ forbids declaration of ‘PackUser’ with no type
# [2023-05-04 17:06:53] [build-err] get_userinfo.h:27: error: expected ‘;’ before ‘*’ token
# [2023-05-04 17:06:53] [build-err] get_userinfo.h: In constructor ‘NSuserinfo_handle::NSuserinfo_handle()’:
# [2023-05-04 17:06:53] [build-err] get_userinfo.h:14: error: ‘_userinfo_handle’ was not declared in this scope


# /data/icg/userstack_all/apps/ngfw_user/um/packuser.h
# /data/icg/system/app/icguser/userinfo/header/packuser.h
# /data/icg/system/app/nsblockpush/packuser.h
# /data/icg/system/um/include/userinfo/packuser.h
# /data/icg/system/um/src/userinfo/packuser.h
# /data/icg/system/system/modules/function/ngfw_user/packuser.h
# /data/icg/system/system/modules/function/ngfw_user/userlib/packuser.h

/opt/codeql/codeql/codeql database create /data/icg/codeql_db/sys/monitor_src_db --language=cpp --source-root /data/icg/system/app/monitor_src/build/ --command='sh make.sh'



# /system/-sslpush/build/make.sh
#  os_unix.c: In function ‘OS_Accept’:
/opt/codeql/codeql/codeql database create /data/icg/codeql_db/sys/sslpush_db --language=cpp --source-root /data/icg/system/sslpush/build/ --command='sh make.sh'



# /system/-app/logcenter/build/make.sh
# [2023-05-04 17:17:59] [build-err] syslog.cpp:2093: error: forward declaration of ‘struct app_behaviour_log_data’
# [2023-05-04 17:17:59] [build-err] syslog.cpp:2168: error: invalid use of incomplete type ‘struct app_behaviour_log_data’
# [2023-05-04 17:17:59] [build-err] syslog.cpp:2093: error: forward declaration of ‘struct app_behaviour_log_data’
# [2023-05-04 17:17:59] [build-err] syslog.cpp:2171: error: invalid use of incomplete type ‘struct app_behaviour_log_data’
# [2023-05-04 17:17:59] [build-err] syslog.cpp:2093: error: forward declaration of ‘struct app_behaviour_log_data’
# [2023-05-04 17:17:59] [build-err] syslog.cpp:2171: error: invalid use of incomplete type ‘struct app_behaviour_log_data’
# [2023-05-04 17:17:59] [build-err] syslog.cpp:2093: error: forward declaration of ‘struct app_behaviour_log_data’
# [2023-05-04 17:17:59] [build-err] syslog.cpp:2174: error: invalid use of incomplete type ‘struct app_behaviour_log_data
/opt/codeql/codeql/codeql database create /data/icg/codeql_db/sys/logcenter_db --language=cpp --source-root /data/icg/system/app/logcenter/build/ --command='sh make.sh'

# /system/-dplan_system/build/make.sh
# [2023-05-04 17:19:34] [build-err] xt_biz_system.c:1:23: error: netentsec.h: No such file or directory
# [2023-05-04 17:19:34] [build-err] xt_biz_system.c:2:26: error: linux/percpu.h: No such file or directory
# [2023-05-04 17:19:34] [build-err] In file included from xt_biz_system.c:3:
# [2023-05-04 17:19:34] [build-err] /usr/include/linux/netfilter.h:57: error: field ‘in’ has incomplete type
# [2023-05-04 17:19:34] [build-err] /usr/include/linux/netfilter.h:58: error: field ‘in6’ has incomplete type
# [2023-05-04 17:19:34] [build-err] xt_biz_system.c:4:34: error: net/pe/parser_engine.h: No such file or directory
# [2023-05-04 17:19:34] [build-err] xt_biz_system.c:5:40: error: net/netfilter/nf_conntrack.h: No such file or directory
# [2023-05-04 17:19:34] [build-err] xt_biz_system.c:6:38: error: external_hook/biz_system.h: No such file or directory
# [2023-05-04 17:19:34] [build-err] xt_biz_system.c:7:46: error: external_hook/sys_domain_chk_cfg.h: No such file or directory
# [2023-05-04 17:19:34] [build-err] xt_biz_system.c:8:27: error: linux/nfhipac.h: No such file or directory
# [2023-05-04 17:19:34] [build-err] xt_biz_system.c:9:30: error: cp/nscp_proc_api.h: No such file or directory
/opt/codeql/codeql/codeql database create /data/icg/codeql_db/sys/dplan_system_db --language=cpp --source-root /data/icg/system/dplan_system/build/ --command='sh make.sh'


# /system/-app/nsicap/build/make.sh
/opt/codeql/codeql/codeql database create /data/icg/codeql_db/sys/nsicap_db --language=cpp --source-root /data/icg/system/app/nsicap/build/ --command='sh make.sh'


# /system/-buildall/make.sh




/audit/-build/make.sh

#/audit/-ns_url_cate/build/make.sh
#编译错误
# [2023-05-04 18:14:13] [build-err] In file included from ns_url_cate.c:35:0:
# [2023-05-04 18:14:13] [build-err] url_ring.h:10:26: fatal error: nscp_cli_api.h: No such file or directory
# [2023-05-04 18:14:13] [build-err]  #include "nscp_cli_api.h"
# [2023-05-04 18:14:13] [build-err]                           ^
# [2023-05-04 18:14:13] [build-err] compilation terminated.
# [2023-05-04 18:14:15] [build-err] make: *** [ns_url_cate.o] Error 1
# [2023-05-04 18:14:15] [build] making ns_url_cate failed!
# [2023-05-04 18:14:15] [build] make ns_url_cate error!
# [2023-05-04 18:14:15] [ERROR] Spawned process exited abnormally (code 1; tried to run: [/opt/codeql/codeql.2.2.3/tools/linux64/preload_trac
# er, sh, make.sh])
/opt/codeql/codeql.2.2.3/codeql database create /data/icg/codeql_db/audit/ns_url_cate_db --language=cpp --source-root /data/icg/audit/ns_url_cate/build/ --command='sh make.sh'



#/audit/-dpdk_so/dplan_url_cate/build/make.sh
#编译错误
/opt/codeql/codeql.2.2.3/codeql database create /data/icg/codeql_db/audit/dpdk_so/dplan_url_cate_db --language=cpp --source-root /data/icg/audit/dpdk_so/dplan_url_cate/build/ --command='sh make.sh'



#/audit/-dpdk_so/dplan_audit_ring/build/make.sh
#/audit/-dpdk_so/tools/build/make.sh
# 编译错误
/opt/codeql/codeql.2.2.3/codeql database create /data/icg/codeql_db/audit/dpdk_so/tools_db --language=cpp --source-root /data/icg/audit/dpdk_so/tools/build/ --command='sh make.sh'


#/userstack_all/-/blob/UserStack_v10_1_1_Main_Branch/build/make.sh
# [2023-05-04 17:30:59] [build-err] In file included from ../../..//include/lib/debug_log_format.h:51,
# [2023-05-04 17:30:59] [build-err]                  from ../../..//include/proxy/gti_skb.h:37,
# [2023-05-04 17:30:59] [build-err]                  from ../../..//include/net/netfilter/nf_conntrack.h:24,
# [2023-05-04 17:30:59] [build-err]                  from ../../..//include/net/pkts_post.h:5,
# [2023-05-04 17:30:59] [build-err]                  from ../../..//include/netentsec.h:43,
# [2023-05-04 17:30:59] [build-err]                  from ../../..//include/ring/ring.h:199,
# [2023-05-04 17:30:59] [build-err]                  from get_slot.c:24:
# [2023-05-04 17:30:59] [build-err] /usr/local/include/glib-2.0/glib.h:38:25: error: glib/gbytes.h: No such file or directory
# [2023-05-04 17:30:59] [build-err] /usr/local/include/glib-2.0/glib.h:39:27: error: glib/gcharset.h: No such file or directory
# [2023-05-04 17:30:59] [build-err] /usr/local/include/glib-2.0/glib.h:46:27: error: glib/genviron.h: No such file or directory
# [2023-05-04 17:30:59] [build-err] /usr/local/include/glib-2.0/glib.h:49:27: error: glib/ggettext.h: No such file or directory
# [2023-05-04 17:30:59] [build-err] /usr/local/include/glib-2.0/glib.h:51:24: error: glib/ghmac.h: No such file or directory
# [2023-05-04 17:30:59] [build-err] /usr/local/include/glib-2.0/glib.h:81:31: error: glib/gstringchunk.h: No such file or directory
# [2023-05-04 17:30:59] [build-err] /usr/local/include/glib-2.0/glib.h:87:30: error: glib/gtrashstack.h: No such file or directory
# [2023-05-04 17:30:59] [build-err] /usr/local/include/glib-2.0/glib.h:93:24: error: glib/guuid.h: No such file or directory
# [2023-05-04 17:30:59] [build-err] /usr/local/include/glib-2.0/glib.h:96:27: error: glib/gversion.h: No such file or directory
# [2023-05-04 17:30:59] [build-err] /usr/local/include/glib-2.0/glib.h:97:33: error: glib/gversionmacros.h: No such file or directory
# [2023-05-04 17:30:59] [build-err] /usr/local/include/glib-2.0/glib.h:103:40: error: glib/deprecated/gallocator.h: No such file or directory
# [2023-05-04 17:30:59] [build-err] /usr/local/include/glib-2.0/glib.h:104:36: error: glib/deprecated/gcache.h: No such file or directory
# [2023-05-04 17:30:59] [build-err] /usr/local/include/glib-2.0/glib.h:105:41: error: glib/deprecated/gcompletion.h: No such file or director
# y
# [2023-05-04 17:30:59] [build-err] /usr/local/include/glib-2.0/glib.h:106:35: error: glib/deprecated/gmain.h: No such file or directory
# [2023-05-04 17:30:59] [build-err] /usr/local/include/glib-2.0/glib.h:107:34: error: glib/deprecated/grel.h: No such file or directory
# [2023-05-04 17:30:59] [build-err] /usr/local/include/glib-2.0/glib.h:108:37: error: glib/deprecated/gthread.h: No such file or directory
# [2023-05-04 17:30:59] [build-err] /usr/local/include/glib-2.0/glib.h:111:36: error: glib/glib-autocleanups.h: No such file or directory
/opt/codeql/codeql/codeql database create /data/icg/codeql_db/userstack_all --language=cpp --source-root /data/icg/userstack_all/build/ --command='sh make.sh'



/web/-build/makeGui.sh