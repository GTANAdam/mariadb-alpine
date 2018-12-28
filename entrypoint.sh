#!/bin/sh

# execute any pre-init scripts
for i in /scripts/pre-init.d/*sh
do
	if [ -e "${i}" ]; then
		. "${i}"
	fi
done

if [ -d "/run/mysqld" ]; then
	chown -R mysql:mysql /run/mysqld
else
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

if [ -d /var/lib/mysql/mysql ]; then
	chown -R mysql:mysql /var/lib/mysql
else
	chown -R mysql:mysql /var/lib/mysql

	mysql_install_db --user=mysql > /dev/null

	MYSQL_DATABASE=${MYSQL_DATABASE:-""}
	MYSQL_USER=${MYSQL_USER:-""}
	MYSQL_PASSWORD=${MYSQL_PASSWORD:-""}

	tfile=`mktemp`
	if [ ! -f "$tfile" ]; then
	    return 1
	fi

	cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;
UPDATE user SET password=PASSWORD("") WHERE user='root' AND host='localhost';
DROP DATABASE test;
EOF

	if [ "$MYSQL_DATABASE" != "" ]; then
	    echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8 COLLATE utf8_general_ci;" >> $tfile

	    if [ "$MYSQL_USER" != "" ]; then
		echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile
	    fi
	fi

	/usr/bin/mysqld --user=mysql --bootstrap --verbose=0 --skip-name-resolve < $tfile
	rm -f $tfile

	for f in /docker-entrypoint-initdb.d/*; do
		case "$f" in
			*.sql)    echo "$0: running $f"; mysql -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE < "$f"; echo ;;
			*.sql.gz) echo "$0: running $f"; gunzip -c "$f" | mysql -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE < "$f"; echo ;;
			*)        echo "$0: ignoring or entrypoint initdb empty $f" ;;
		esac
		echo
	done
fi

# execute any pre-exec scripts
for i in /scripts/pre-exec.d/*sh
do
	if [ -e "${i}" ]; then
		. ${i}
	fi
done

exec /usr/bin/mysqld --user=mysql --console --skip-name-resolve $@
