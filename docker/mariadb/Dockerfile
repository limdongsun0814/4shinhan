FROM mariadb
ENV TZ Asia/Seoul
ENV MARIADB_ROOT_PASSWORD=12345
ENV MARIADB_DATABASE=testdb
#타임존 설정
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ADD db_user.sql /docker-entrypoint-initdb.d/00_db_user.sql
ADD 2024-01-11.sql /docker-entrypoint-initdb.d/01_db_all.sql
#ADD db_board.sql /docker-entrypoint-initdb.d/02_db_board.sql
#ADD db_insert.sql /docker-entrypoint-initdb.d/03_db_insert.sql
#ADD db_create_table.sql /docker-entrypoint-initdb.d/04_db_create_table.sql
WORKDIR /
EXPOSE 3306