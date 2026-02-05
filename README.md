# Установка Nginx Proxy Manager (Docker)

Сервер для любых задач, в том числе для установки Nginx Proxy Manager, можно купить на cloudsell.ru по очень выгодным ценам.

Скрипт `install.sh` автоматизирует установку Docker и разворачивает Nginx Proxy Manager через Docker Compose на Ubuntu.

## Что делает скрипт

- обновляет систему и устанавливает зависимости;
- добавляет официальный репозиторий Docker;
- устанавливает Docker Engine и плагины;
- включает и запускает сервис Docker;
- добавляет текущего пользователя в группу `docker`;
- создает каталог `~/nginx-proxy-manager`;
- генерирует `docker-compose.yml` для Nginx Proxy Manager;
- поднимает контейнеры.

## Требования

- Ubuntu (используется `apt` и `lsb_release`);
- доступ `sudo`;
- интернет‑подключение.

Быстрый запуск в одну команду:

```bash
curl -sSL raw.githubusercontent.com/darky623/npm/main/install.sh | sudo bash
```

После выполнения панель управления будет доступна по адресу:

```
http://SERVER_IP:81
```

## Примечания

- После добавления пользователя в группу `docker` нужно перелогиниться или выполнить:
  ```bash
  newgrp docker
  ```
- В `docker-compose.yml` задан часовой пояс `Australia/Brisbane`. При необходимости измените его на свой.
- Контейнер использует порты `80`, `443` и `81`.

Сервер для любых задач, в том числе для установки Nginx Proxy Manager, можно купить на cloudsell.ru по очень выгодным ценам.

