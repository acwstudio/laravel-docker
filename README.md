# laravel-docker

1. clone repository `# git clone --branch=master https://github.com/acwstudio/laravel-docker.git name_your_docker_project`
2. `# cd name_your_project`
3. `# cp .env.examole .env`
4. edit .env file
5. create symlink to folder with your Laravel-app `# ln -snf /path/to/your/laravel-project` project
6. create images `# docker-compose build`
7. create containers`# docker-compose up -d`
8. look at created images `# docker images`
9. look at created containers `# docker ps -a`

**Разворачиваем проект**

1. create folders structure 
    ```console 
   $ cd ~/
   $ mkdir projects/my_project
   $ cd projects/my_project
   $ mkdir laravel
   $ mkdir docker
   ```
1. you have to get this structure
    ```console
   ~/projects
        |-/my_project
            |-/laravel
            |-/docker
    ```
1. clone the laravel-docker project in the `my_project/docker/` folder
    ```consol
   $ git clone https://github.com/acwstudio/laravel-docker.git docker
    ```
1. clone or install Laravel application in the `my_project/laravel/project/` folder
    ```console
   $ git clone https://github.com/you_account/laravel_project.git laravel
    ```
1. Move storage folder from laravel to docker
    ```console
   $ cp -r ~/projects/my-project/laravel/storage ~/projects/my-project/docker/project/storage
    ```
1. create .env file for Laravel in docker/project/ext-configs folder
    ```console
    $ cp ~/projects/my-project/laravel/.env.example ~/projects/my-project/docker/project/ext-configs/.env
   ```
1. create .env file for docker-compose
    ```console
    $ cp ~/projects/my-project/docker/project/.env.example ~/projects/my-project/docker/project/.env
1. edit project/.env file for docker-compose, for example
    ```dotenv
   APP_ENV=local
   PHP_VERSION=7.2
   # Local working directory webroot
   LOCAL_LARAVEL_DIR=./project/my_project
   LOCAL_LARAVEL_STORAGE_DIR=./project/storage
   LOCAL_LARAVEL_EXTERNAL_DIR=./project/ext-configs
   # Remote working directory webroot
   REMOTE_LARAVEL_DIR=/var/www
   
   # MYSQL Environment
   MYSQL_DATABASE=my_project_db
   MYSQL_ROOT_PASSWORD=secret
   
   # Port Mappings
   PORT_DATABASE=3300
   #PORT_MAILCATCHER=1080
   #PORT_PHPMYADMIN=8081
   PORT_HTTP=8000
   #PORT_HTTPS=8100
   #PORT_REDIS=6379
    ```
1. edit project/ext-configs/.env file for Laravel
    ```dotenv
    DB_CONNECTION=mysql
    DB_HOST=db
    DB_PORT=3306
    DB_DATABASE=my_project_db
    DB_USERNAME=root
    DB_PASSWORD=secret
    ```