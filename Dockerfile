FROM alpine:latest

ADD entrypoint.sh /scripts/entrypoint.sh
RUN apk add --no-cache mariadb && \
    rm -f /var/cache/apk/* && \
    mkdir /docker-entrypoint-initdb.d && \
    mkdir /scripts/pre-exec.d && \
    mkdir /scripts/pre-init.d && \
    chmod -R 755 /scripts && \ 
    for p in aria* myisam* mysqld_* innochecksum  \
        mysqlslap replace wsrep* \
        resolve_stack_dump mysqlbinlog msql2mysql \
        $(cd /usr/bin; ls mysql_*| grep -v mysql_install_db); \
        do eval rm /usr/bin/${p}; done

EXPOSE 3306
VOLUME ["/var/lib/mysql"]
ENTRYPOINT ["/scripts/entrypoint.sh"]
