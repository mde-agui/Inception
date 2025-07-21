VOLUME_PATH := /home/$(USER)/data
ENV_PATH := srcs/.env

all:
	mkdir -p $(VOLUME_PATH)/wordpress $(VOLUME_PATH)/database
	sed "s|\$$USER|$(USER)|g" $(ENV_PATH) > $(ENV_PATH).tmp && mv $(ENV_PATH).tmp $(ENV_PATH)
	docker-compose -f srcs/docker-compose.yml --env-file $(ENV_PATH) up --build -d

stop:
	docker-compose -f srcs/docker-compose.yml --env-file $(ENV_PATH) down

clean:
	docker-compose -f srcs/docker-compose.yml --env-file $(ENV_PATH) down -v
	docker system prune -f

fclean: clean
	rm -rf $(VOLUME_PATH)/wordpress/* $(VOLUME_PATH)/database/*

re: fclean all

.PHONY: all stop clean fclean re
