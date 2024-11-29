# **Quadraweb WordPress Development Environment**

Quadraweb’s `docker-wordpress-dev-env` offers a fast, one-command setup for local WordPress development or presentation. Pre-configured with essential plugins, pages, and PHPMyAdmin, this solution streamlines your workflow using Docker and WP-CLI automation, letting you focus on building and showcasing your projects.

---

## Why Choose Quadraweb's WordPress Dev Environment?

At the core of Quadraweb’s philosophy is **simplicity and speed**. This environment provides a **one-command deployment** for spinning up a **WordPress site** for development or presentation. With everything pre-installed—plugins, pages, and essential configurations—you can dive straight into building your site without setup hassles. Automate your WordPress setup with our **JSON-powered WP-CLI blueprint**, manage database with **PHPMyAdmin** at `http://localhost:8080`, and enjoy persistent file storage for easy customization. This solution is fully customizable, designed to streamline your development process and ensure a smooth, efficient experience.

---

> **Note**: This repository is intended for **local development only**. It is **not recommended for production** use.

---

## Features

- **One-Click Local WordPress Setup:** Use Docker Compose to bring your development environment to life with a single command.
- **WP-CLI Integration:** Automate plugin installations, theme setups, and page creation via an easily configurable JSON file.
- **NGINX Support:** Customizable NGINX configurations for advanced users (optional).
- **Database Access with PHPMyAdmin:** Fully integrated database management tool running on http://localhost:8080.
- **Customizable .env File:** Simplify environment variable management for database credentials.
- **Persistent Storage:** Keep WordPress data and files accessible in your local file system for direct customization.

---

## Prerequisites

- **Docker**: Installed and running. [Get Docker](https://www.docker.com/get-started)
- **Text Editor**: Use any editor of your choice (e.g., [VSCode](https://code.visualstudio.com/), [Sublime Text](https://www.sublimetext.com/), [Atom](https://atom.io/)).
- **Operating System**: Works on **macOS**, **Windows**, and **Linux**.

---

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/Quadraweb/docker-wordpress-dev-env
```

```bash
cd docker-wordpress-dev-env
```

---

### 2. Use the Pre-Configured `.env` File

The repository includes an `.env` file that makes it easy to adjust key values such as database credentials, WordPress version, and other configurations. Simply open and edit the `.env` file to suit your local setup.

- **DB_NAME=wordpress**: Database Name
- **MYSQL_ROOT_PASSWORD**: Root password for the MySQL database.
- **WORDPRESS_DB_USER**: WordPress database username.
- **WORDPRESS_DB_PASSWORD**: WordPress database password.

---

### 3. Adjust wp-cli-commands.json to define plugins, pages, and any other configurations:

The wp-cli-commands.json file allows you to `automate WordPress setup tasks`, such as installing the core, managing plugins, and creating pages. Below is an example structure and explanation:

```bash
[
  {
    "command": "core install",
    "args": {
      "url": "http://localhost",
      "title": "MySite",
      "admin_user": "admin",
      "admin_password": "admin",
      "admin_email": "admin@example.com"
    }
  },
  {
    "command": "plugin install",
    "args": {
      "slug": "classic-editor",
      "activate": true,
      "insecure": true
    }
  },
  {
    "command": "post create",
    "args": {
      "post_type": "page",
      "post_title": "About Us",
      "post_content": "This is the about us page.",
      "post_status": "publish"
    }
  }
]
```

#### Fields Explained

`command:` The WP-CLI command to execute (e.g., core install, plugin install, post create).
`args:` The arguments for the command in key-value format.

---

### 4. Start the Containers

Run the following command to start WordPress, MySQL, and PHPMyAdmin:

```bash
docker-compose up
```

This command will start all necessary services, and WordPress files will be accessible in the root folder for easy editing.

---

### 5. Access Your Local WordPress Site

Visit [http://localhost](http://localhost) in your browser to access the WordPress site. You can log in using the default credentials set in your `wp-cli-commands.json ` file or through the WordPress setup process if it's your first time.

---

### 6. Access PHPMyAdmin

you can access PHPMyAdmin at [http://localhost:8080](http://localhost:8080). Use the following details to log in:

- **Server:** `db`
- **Username:** Your MySQL username (from `.env`) pre-defined `wordpress`
- **Password:** Your MySQL password (from `.env`) pre-defined `wordpress`

---

## Stopping and Removing Containers

To stop the running containers, press `CTRL+C` in the terminal where the containers are running or use:

```bash
docker-compose down
```

This command will stop the containers but keep the data. To remove containers and volumes (if you want a clean start), use:

---

```bash
docker-compose down --volumes
```

---

## Connect to WP CLI container

This command will open an interactive terminal and you will be able to run wp commands

```bash
docker exec -it wp-cli bash
```

---

## File Structure

.
├── `.env `# Environment variables for database credentials
├── `docker-compose.yml `# Docker Compose configuration
├── `nginx-conf/ `# Customizable NGINX configurations (optional)
├── `wordpress/ `# Persistent WordPress files and data
├── `wp-cli-commands.json `# JSON blueprint for automated WP-CLI commands
└── `run-wp-commands.sh `# Shell script to execute WP-CLI commands

---

## Security Notice

This setup is for **local development only** and should **not be used in production** environments. It lacks essential security configurations such as SSL, hardened permissions, and optimized performance for public-facing websites. Always ensure that sensitive data is kept secure and that best practices for security are followed in production setups.

---

## License

This project is open-source and licensed under the [MIT License](https://opensource.org/licenses/MIT). Feel free to use, modify, and distribute it as per the terms of the license. Contributions are welcome to help make this solution even better!

---
