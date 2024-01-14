use testdb;
create user 'test'@'%' identified by '12345';
grant all privileges on *.* to 'test'@'%';