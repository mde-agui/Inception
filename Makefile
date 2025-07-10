all:
	mkdir -p /home/mde-agui/data/wordpress /home/mde-agui/data/database
	docker-compose -f srcs/docker-compose.yml up --build -d
	docker network create inception

stop:
	docker-compose -f srcs/docker-compose.yml down

clean:
	docker-compose -f srcs/docker-compose.yml down -v
	docker system prune -f

fclean: clean
	sudo rm -rf /home/mde-agui/data/wordpress/* /home/mde-agui/data/database/*

re: fclean all

.PHONY: all stop clean fclean re
