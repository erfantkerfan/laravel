1. install Docker **(for ubuntu)**:
    1. `curl -sSL https://get.docker.com/ | sh`
    2. `sudo apt install docker-compose`
    3. `sudo usermod -aG docker $USER`
    4. `sudo systemctl enable docker.service`
    5. `sudo systemctl start docker.service`
    6. log out and login again in your system
2. run project:
    1. fork the project
    2. clone the project
    3. add this alias to your .bashrc or .zshrc `alias sail='[ -f sail ] && bash sail || bash vendor/bin/sail'`
    4. remove `vendor` directory if exists
    5. `docker run --rm -u "$(id -u):$(id -g)" -v $(pwd):/var/www/html -w /var/www/html laravelsail/php80-composer:latest composer install --ignore-platform-reqs`
    6. **DON'T FORGET TO** copy `.env.example` as `.env` before going further
    7. `docker login docker2.vandar.ir` ask for credentials from SRE group
    8. `sail up -d`
    9. `sail npm ci`
    10. `sail artisan key:generate`
    11. `sail composer install`
    12. `sail down`
    13. `sail up -d`
