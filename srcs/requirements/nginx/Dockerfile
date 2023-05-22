FROM debian:buster

RUN apt update -y -qq &&\
	apt upgrade -y -qq &&\
	apt install -y -qq nginx openssl

COPY conf/fforlini.42Roma.conf /etc/nginx/sites-enabled/

RUN	openssl req -x509 -nodes -days 365 -subj "/C=IT/ST=RM/O=fforlini/OU=Gambling/CN=localhost/mail=perchelabiciemiaporcodedio@gmail.com" -newkey rsa:2048 -keyout /etc/ssl/fforlini.key -out /etc/ssl/fforlini.crt

CMD ["nginx", "-g", "daemon off;"]