# laravel-docker

1. clone repository `# git clone --branch=master https://github.com/acwstudio/laravel-docker.git name_your_docker_project`
2. `# cd name_your_project`
3. `# cp .env.examole .env`
4. edit .env file
5. create symlink to folder with your Laravel-app `# ln -snf /path/to/your/laravel-project` project
6. create images `# docker-compose build`
7. create containers`# docker-compose up -d`
