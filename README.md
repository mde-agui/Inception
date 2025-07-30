# Inception - Dockerized Web Application

![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Docker Compose](https://img.shields.io/badge/Docker_Compose-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![42](https://img.shields.io/badge/42-Project-00BABC?style=for-the-badge)
![Score](https://img.shields.io/badge/Score-121%25-brightgreen?style=for-the-badge)

## 📋 Project Overview

**Inception** is a project from the 42 school curriculum that introduces containerization and orchestration using **Docker** and **Docker Compose**. The goal is to create a multi-container web application running NGINX (web server with TLSv1.2/TLSv1.3), WordPress (CMS), and MariaDB (database), with persistent data stored in Docker volumes. Bonus services include Redis (caching), FTP (secure file transfer), a static website, Adminer (database management), and monitoring tools (Prometheus, Grafana, Node Exporter, Portainer). The project enforces strict requirements, such as custom Dockerfiles based on `debian:bullseye`, a single bridge network (`inception`), and no forbidden networking options (e.g., `network: host`, `--link`). All services must restart automatically (`restart: always`), and data must persist across container stops and VM reboots. Achieved a score of **121%** for completing the mandatory part perfectly and implementing all bonus services.

## ✨ Key Features

- **Mandatory Part**:
  - **NGINX**: Serves WordPress over HTTPS (`https://<DOMAIN_NAME>:443`) with a self-signed SSL certificate, using TLSv1.2 or TLSv1.3. Forwards PHP requests to `wordpress:9000`.
  - **WordPress**: Runs a CMS with PHP-FPM, allowing post creation, commenting, and page editing. Uses a persistent volume (`/home/usr/data/wordpress`) and connects to MariaDB.
  - **MariaDB**: Manages the WordPress database with two users (no “admin” or “Administrator” in usernames), stored in a persistent volume (`/home/usr/data/database`).
  - **Docker Volumes**: Persist WordPress files and database data at `/home/usr/data`.
  - **Docker Network**: Uses a single bridge network (`inception`) for inter-container communication.
  - **Restart Policy**: All containers use `restart: always` for automatic recovery.
- **Bonus Part**:
  - **Redis**: Caches WordPress data, improving performance, with a persistent configuration.
  - **FTP**: Provides secure file transfers to the WordPress volume using VSFTPD with SSL/TLS on port 21 and passive ports (10000–10100).
  - **Static Website**: Serves a non-PHP HTML page (e.g., a CV) on `http://<DOMAIN_NAME>:8080`.
  - **Adminer**: Manages the MariaDB database via a web interface on `http://<DOMAIN_NAME>:8081`, using NGINX and PHP-FPM with Supervisor.
  - **Monitoring Tools**:
    - **Prometheus**: Collects metrics from NGINX, WordPress, MariaDB, and Node Exporter on `http://<DOMAIN_NAME>:9090`.
    - **Grafana**: Visualizes metrics on `http://<DOMAIN_NAME>:3000`.
    - **Node Exporter**: Provides system-level metrics on `http://<DOMAIN_NAME>:9100`.
    - **Portainer**: Manages Docker resources via a web UI on `https://<DOMAIN_NAME>:9443`.
- **Compliance**:
  - Custom Dockerfiles based on `debian:bullseye` (except for official `prom/node-exporter` and `portainer/portainer-ce` images).
  - No hardcoded credentials (uses `.env` for environment variables).
  - No forbidden networking (`network: host`, `--link`, `links:`) or hacky commands (`tail -f`, `sleep infinity`).
  - Persistent data across container stops and VM reboots.
  - Adheres to 42’s Norminette equivalent (e.g., clean configuration files, no trailing whitespace).

## 🛠️ Prerequisites

- **Operating System**: UNIX-based (Linux, macOS, etc.).
- **Tools**: `docker`, `docker-compose` (v2.x), `make`.
- **Dependencies**: Installed via Dockerfiles (e.g., NGINX, PHP-FPM, MariaDB, Redis, VSFTPD, Adminer, Prometheus, Grafana, Node Exporter, Portainer).
- **Environment**: A virtual machine with sufficient resources (e.g., 2GB RAM, 20GB disk).

## 🚀 Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/mde-agui/Inception.git
   cd Inception
   ```

2. Set up the environment:
   - Ensure `/etc/hosts` maps the domain to the local IP:
     ```bash
     echo "127.0.0.1 *the domain name of your choosing*" | sudo tee -a /etc/hosts
     ```

3. Set the environments on the .env file.

4. Build and start the application:
   ```bash
   make all
   ```
   This creates volumes (`/home/usr/data/wordpress`, `/home/usr/data/database`), updates `.env` to get the volumes' paths, and runs `docker-compose up --build -d`.

## 📖 Usage

Run the application with:
```bash
make all
```

Access services:
- **WordPress**: `https://<DOMAIN_NAME>:443` (use `-k` with `curl` for self-signed certificates).
- **Static Website**: `http://<DOMAIN_NAME>:8080`.
- **Adminer**: `http://<DOMAIN_NAME>:8081`.
- **Prometheus**: `http://<DOMAIN_NAME>:9090`.
- **Grafana**: `http://<DOMAIN_NAME>:3000`.
- **Node Exporter**: `http://<DOMAIN_NAME>:9100`.
- **Portainer**: `https://<DOMAIN_NAME>:9443`.
- **FTP**: Connect via `ftp <DOMAIN_NAME>` (port 21) with credentials from `.env`.

Example commands:
```bash
# Test WordPress
curl -k https://<DOMAIN_NAME>:443

# Test FTP
ftp <DOMAIN_NAME>
# Use $FTP_USER and $FTP_PASS from .env

# Check container status
docker compose ps

# View logs
docker compose logs nginx
```

## 📂 Project Structure

```
Inception/
├── Makefile
├── srcs/
│   ├── docker-compose.yml
|   ├── .env (*DON'T FORGET TO SET ALL THE FIELDS!!!*)
│   ├── requirements/
│   │   ├── nginx/
│   │   │   ├── Dockerfile
│   │   │   ├── nginx.conf
│   │   │   └── generate-ssl.sh
│   │   ├── wordpress/
│   │   │   ├── Dockerfile
│   │   │   ├── wp-config.php.template
│   │   │   ├── www.conf
│   │   │   └── wp-setup.sh
│   │   ├── mariadb/
│   │   │   ├── Dockerfile
│   │   │   ├── init.sql
│   │   │   └── entrypoint.sh
│   │   ├── bonus/
│   │   │   ├── redis/
│   │   │   │   ├── Dockerfile
│   │   │   │   └── redis.conf
│   │   │   ├── ftp/
│   │   │   │   ├── Dockerfile
│   │   │   │   └── vsftpd.conf
│   │   │   ├── static/
│   │   │   │   ├── Dockerfile
│   │   │   │   ├── nginx.conf
│   │   │   │   └── site/
│   │   │   │       └── index.html
│   │   │   ├── adminer/
│   │   │   │   ├── Dockerfile
│   │   │   │   ├── nginx.conf
│   │   │   │   └── supervisord.conf
│   │   │   ├── prometheus/
│   │   │   │   ├── Dockerfile
│   │   │   │   └── prometheus.yml
│   │   │   ├── grafana/
│   │   │   │   ├── Dockerfile
│   │   │   │   └── grafana.ini
│   │   │   ├── node_exporter/
│   │   │   │   └── Dockerfile
│   │   │   ├── portainer/
│   │   │   │   └── Dockerfile
└── README.md
```

## 🛠️ Makefile Commands

| Command       | Description                              |
|---------------|------------------------------------------|
| `make`        | Alias for `make all`.                    |
| `make all`    | Builds and starts all containers.        |
| `make down`   | Stops all containers (`docker-compose down`). |
| `make stop`   | Stops all containers (`docker-compose stop`). |
| `make start`  | Starts all containers (`docker-compose start`). |
| `make clean`  | Stops containers and removes images/volumes. |
| `make fclean` | Removes volume data (`/home/mde-agui/data`). |
| `make re`     | Rebuilds and restarts from scratch.      |

## 🔍 Technical Details

- **Docker Concepts Covered**:
  - **Dockerfiles**: Custom images for NGINX, WordPress, MariaDB, Redis, FTP, static website, Adminer, Prometheus, and Grafana, based on `debian:bullseye`. Official images used for Node Exporter and Portainer.
  - **Docker Compose**: Orchestrates services with a single bridge network (`inception`), persistent volumes (`wordpress_files`, `wordpress_db`), and `restart: always` policy.
  - **Volumes**: Persist data at `/home/usr/data/wordpress` (WordPress files) and `/home/usr/data/database` (MariaDB data).
  - **Networking**: Uses a bridge network for inter-container communication (e.g., `wordpress` connects to `mariadb:3306`).
  - **Security**: Self-signed SSL certificates for NGINX and FTP, with TLSv1.2/TLSv1.3 for HTTPS.
  - **Health Checks**: Implemented for WordPress and MariaDB to ensure service readiness.
  - **Environment Variables**: Managed via `.env` (e.g., `DB_NAME`, `WP_ADMIN_USER`, `FTP_PASS`).
- **Bonus Services**:
  - **Redis**: Integrates with WordPress via `redis-cache` plugin, using a password-protected configuration.
  - **FTP**: Uses VSFTPD with SSL/TLS, allowing file uploads to the WordPress volume.
  - **Static Website**: Serves HTML content on port 8080, separate from WordPress.
  - **Adminer**: Provides a web-based MariaDB management tool with NGINX and PHP-FPM.
  - **Monitoring**: Prometheus collects metrics, Grafana visualizes them, Node Exporter provides system metrics, and Portainer manages Docker resources.
- **Constraints**:
  - No hardcoded credentials (uses `.env`).
  - No forbidden networking (`network: host`, `--link`, `links:`).
  - No hacky commands (`tail -f`, `bash`, `sleep infinity`).
  - Persistent data across container stops and VM reboots.
  - Admin usernames exclude “admin” or “Administrator”.
- **Troubleshooting Insights**:
  - **Blank Page Issue**: Addressed by verifying database connectivity (`mariadb -h mariadb -u $DB_USER -p$DB_PASS`), NGINX configuration (`fastcgi_pass wordpress:9000`), and PHP-FPM status.
  - **Restart Issue**: Ensured `restart: always` in `docker-compose.yml` and used `docker-compose up -d` instead of `docker run` to apply the policy.

## 📝 Notes

- **Implementation Details**:
  - **NGINX**: Configured with TLSv1.2/TLSv1.3, self-signed certificates generated by `generate-ssl.sh`, and PHP forwarding to `wordpress:9000`.
  - **WordPress**: Uses PHP-FPM and WP-CLI for setup, with `wp-config.php` generated from environment variables.
  - **MariaDB**: Initializes with `init.sql`, creating two users and the `wordpress` database.
  - **Redis**: Configured with `appendonly` for persistence and integrated with WordPress via `redis-cache`.
  - **FTP**: Uses VSFTPD with SSL/TLS and passive mode (ports 10000–10100).
  - **Monitoring**: Prometheus scrapes metrics from all services, visualized in Grafana. Portainer uses a persistent volume (`portainer_data`).
- **Testing**:
  - Mandatory part: Tested WordPress functionality (posts, comments, page edits), HTTPS access, and data persistence.
  - Bonus part: Verified Redis caching, FTP uploads, static website, Adminer, and monitoring tools.
  - Restart policy: Confirmed with `docker stop <container-id>` and `docker compose ps`.
  - Persistence: Validated after container stops and VM reboots.
- **Evaluation**:
  - Achieved **121%** by completing the mandatory part perfectly and implementing all bonus services.
- **Makefile**: Simplifies setup with `make all`, `stop`, `clean`, `fclean`, and `re`.

## 📜 License

This project is licensed under the [MIT License](LICENSE).

## 👤 Author

**mde-agui**  
GitHub: [mde-agui](https://github.com/mde-agui)

---

⭐️ If you find this project useful, consider giving it a star on GitHub!
