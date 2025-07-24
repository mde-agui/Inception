USER_PATH := /home/$(USER)
VOLUME_PATH := $(USER_PATH)/data
ENV_PATH := srcs/.env

all:
	mkdir -p $(VOLUME_PATH)/wordpress $(VOLUME_PATH)/database
	sudo chown -R $(USER):$(USER) $(VOLUME_PATH)/wordpress
	sudo chown -R root:root $(VOLUME_PATH)/database
	if ! grep -q "WORDPRESS_PATH=" $(ENV_PATH); then \
		echo "WORDPRESS_PATH=$(VOLUME_PATH)/wordpress" >> $(ENV_PATH); \
	fi; \
	if ! grep -q "DATABASE_PATH=" $(ENV_PATH); then \
		echo "DATABASE_PATH=$(VOLUME_PATH)/database" >> $(ENV_PATH); \
	fi
	docker-compose -f srcs/docker-compose.yml --env-file $(ENV_PATH) up -d --build

down:
	docker-compose -f srcs/docker-compose.yml down

stop:
	docker-compose -f srcs/docker-compose.yml stop

start:
	docker-compose -f srcs/docker-compose.yml start

clean: down
	docker system prune -f

fclean: clean
	rm -rf $(VOLUME_PATH)/wordpress/* $(VOLUME_PATH)/database/*

re: fclean all

.PHONY: all down stop start clean fclean re

