FROM 		debian:buster

WORKDIR /var/hugo/fforlini_static

RUN 	apt update -y && \
        apt upgrade -y && \
        apt install hugo git -y

RUN     hugo new site /var/hugo/fforlini_static && \
        cd /var/hugo/fforlini_static && \
        git clone https://github.com/vaga/hugo-theme-m10c themes/m10c && \
        hugo new posts/fforlini.html && \
        hugo -b https://fforlini.42.fr/static

COPY    conf/config.toml      /var/hugo/fforlini_static/config.toml
COPY    conf/fforlini.html     /var/hugo/fforlini_static/content/posts/fforlini.html
COPY    conf/avatar.jpg       /var/hugo/fforlini_static/themes/m10c/static/avatar.jpg
COPY    conf/fforlini.html         /var/hugo/fforlini_static/content/about/index.html

EXPOSE 1313

CMD     ["hugo", "server", "--bind=0.0.0.0", "--baseURL=https://fforlini.42.fr/static", \
        "-p", "1313", "--logFile=/dev/stdout", "--appendPort=false"]
