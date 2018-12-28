# Lightweight mariadb docker container

Yet another MariaDB docker container based on https://github.com/yobasystems/alpine-mariadb, while the base repo focuses on the minimal size, this fork takes it even further by removing the unnecessary binaries without sacrificing proper functionality.

### Size comparison with other projects

| Name                       | Size |
| -------------------------- | --------------- |
| mysql                      | [![](https://images.microbadger.com/badges/image/mysql.svg)](https://microbadger.com/images/mysql "Get your own image badge on microbadger.com")          |
| mariadb                    | [![](https://images.microbadger.com/badges/image/mariadb.svg)](https://microbadger.com/images/mariadb "Get your own image badge on microbadger.com")           |
| bitnami/mariadb            | [![](https://images.microbadger.com/badges/image/bitnami/mariadb.svg)](https://microbadger.com/images/bitnami/mariadb "Get your own image badge on microbadger.com")           |
| webhippie/mariadb          | [![](https://images.microbadger.com/badges/image/webhippie/mariadb.svg)](https://microbadger.com/images/webhippie/mariadb "Get your own image badge on microbadger.com")            |
| yobasystems/alpine-mariadb | [![](https://images.microbadger.com/badges/image/yobasystems/alpine-mariadb.svg)](https://microbadger.com/images/yobasystems/alpine-mariadb "Get your own image badge on microbadger.com")            |
| **adambh/mariadb-alpine**   | [![](https://images.microbadger.com/badges/image/adambh/mariadb-alpine.svg)](https://microbadger.com/images/adambh/mariadb-alpine "Get your own image badge on microbadger.com") |
| jbergstroem/mariadb-alpine | [![](https://images.microbadger.com/badges/image/jbergstroem/mariadb-alpine.svg)](https://microbadger.com/images/jbergstroem/mariadb-alpine "Get your own image badge on microbadger.com")           |

### Ommited binaries
-   mariadb-client
-   aria_chk
-   aria_dump_log
-   aria_ftdump
-   aria_pack
-   aria_read_log
-   myisamchk
-   myisamlog
-   myisampack
-   mysqld_multi
-   mysqld_safe
-   mysqld_safe_helper
-   innochecksum
-   mysqlslap
-   replace
-   wsrep_sst_common
-   wsrep_sst_mariabackup
-   wsrep_sst_mysqldump
-   wsrep_sst_rsync
-   wsrep_sst_xtrabackup
-   wsrep_sst_xtrabackup-v2
-   resolve_stack_dump
-   mysqlbinlog
-   mysql_client_test_embedded
-   mysql_convert_table_format
-   mysql_embedded
-   mysql_plugin
-   mysql_secure_installation
-   mysql_setpermission
-   mysql_tzinfo_to_sql
-   mysql_upgrade
-   mysql_zap
-   mssql2mysql

## Environment Variables:
* `MYSQL_DATABASE`: specify the name of the database
* `MYSQL_USER`: specify the User for the database
* `MYSQL_PASSWORD`: specify the User password for the database
* `MYSQL_ROOT_PASSWORD`: specify the root password for Mariadb

## Usage

```bash
docker run --rm --name mariadb -e MYSQL_ROOT_PASSWORD=root -p 3306:3306 -d adambh/mariadb-alpine:latest

```


> https://mariadb.org/
