create user xrad_user with encrypted password 'xrad_user';
create user app_user with encrypted password 'app_user';
CREATE DATABASE "appdb" WITH OWNER "app_user" ENCODING 'UTF8' LC_COLLATE = 'ru_RU.UTF-8' LC_CTYPE = 'ru_RU.UTF-8';
CREATE DATABASE "xraddb" WITH OWNER "xrad_user" ENCODING 'UTF8' LC_COLLATE = 'ru_RU.UTF-8' LC_CTYPE = 'ru_RU.UTF-8';
ALTER USER xrad_user WITH SUPERUSER;
ALTER USER app_user WITH SUPERUSER;

