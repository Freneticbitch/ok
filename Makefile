HOME_DIR != getent passwd $(SUDO_USER) | cut -d: -f6;

all:
	mkdir -p ${HOME_DIR}/data/fforlini_nginx
	mkdir -p ${HOME_DIR}/data/db
	docker compose -f srcs/docker-compose.yml build 
	docker compose -f srcs/docker-compose.yml up -d

install:
	apt update -y
	apt install ca-certificates curl gnupg lsb-release -y
	install -m 0755 -d /etc/apt/keyrings
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
	gpg --batch --yes --dearmor -o /etc/apt/keyrings/docker.gpg
	chmod a+r /etc/apt/keyrings/docker.gpg
	echo "deb [arch=$(shell dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
	https://download.docker.com/linux/ubuntu $(shell lsb_release -cs) stable" | \
	tee /etc/apt/sources.list.d/docker.list > /dev/null
	apt update -y
	apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
	sh -c -e "echo '127.0.0.1 fforlini.42.fr' >> /etc/hosts";
	sh -c -e "echo '127.0.0.1 www.fforlini.42.fr' >> /etc/hosts";

clean:
	docker compose -f srcs/docker-compose.yml down

fclean: clean
	rm -rf /home/$(SUDO_USER)/data/

re: fclean all

clear-all: fclean
	docker system prune -af

.PHONY: all clean fclean re
