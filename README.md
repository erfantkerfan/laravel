## Dev setup with Docker:

1. install Docker **(for ubuntu)**:
    1. `sudo apt-get update`
    2. `sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release`
    3. `curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg`
    4. `echo \
       "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null`
    5. `sudo apt-get update`
    6. `sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose`
    7. `sudo groupadd docker`
    8. `sudo usermod -aG docker $USER`
    9. `sudo systemctl enable docker.service`
    10. `sudo systemctl enable containerd.service`
    11. restart your PC
2. run project:
    1. fork the project
    2. clone the project
    3. add this alias to your favorite terminal `alias sail='[ -f sail ] && bash sail || bash vendor/bin/sail'`
    4. remove `vendor` directory if exists
    5. `docker run --rm -u "$(id -u):$(id -g)" -v $(pwd):/var/www/html -w /var/www/html laravelsail/php80-composer:latest composer install --ignore-platform-reqs`
    6. **DON'T FORGET TO** copy `.env.example` as `.env` before going further
    7. `sail up -d`
    9. `sail npm ci`
    10. `sail composer install`
    13. `sail down`
    14. `sail up -d`
