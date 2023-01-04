{{ define "my.cnf" }}
[client-server]
socket = /mariadb/run/mysqld.sock

[mysqldump]
quick
quote-names
max_allowed_packet      = 16M

# this is only for the mysqld standalone daemon
[mysqld]
user                    = mysql
pid-file                = /mariadb/run/mysqld.pid
basedir                 = /usr
datadir                 = /mariadb/data
tmpdir                  = /tmp
lc-messages-dir         = /usr/share/mysql
lc-messages             = en_US
skip-external-locking
bind-address            = 127.0.0.1
expire_logs_days        = 1
# https://mariadb.com/kb/en/securing-connections-for-client-and-server/
#ssl-ca = /etc/mysql/cacert.pem
#ssl-cert = /etc/mysql/server-cert.pem
#ssl-key = /etc/mysql/server-key.pem
#require-secure-transport = on
character-set-server  = utf8mb4
collation-server      = utf8mb4_general_ci

[mysqld_safe]
nice = 0
skip_log_error
syslog
{{ end }}