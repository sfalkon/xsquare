# 

### Процесс развёртывание компонентов 

1. Запустить скрипт инициализации
    ```bash
    ./init.sh
    ```
1. Собрать образ postgresql16 с ru_RU.UTF8 локалью и расширение http
    ```bash
    docker compose build
    ```
1. Запустить окружение
    ```bash
    docker compose up
    ```
1. Приложение доступно по адресам
    - http://localhost - приложение
    - http://localhost:8080 - IDE
    - http://localhost:8887 - RestAPI (xdac)
    - http://localhost:8886 - Reports
1. Необходимо войти в IDE. Далее:
    1. В боковой панели выбираем: Настройки -> Основные
    1. Заменит значение в поле "URL приложения" на http://localhost
    1. Заменит значение в поле "Сервер отчётов" на http://xreport:8886/

