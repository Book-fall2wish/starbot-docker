mirai项目地址：https://github.com/mamoe/mirai
starbot项目地址：https://github.com/Starlwr/StarBot

本项目仅将starbot整合至docker中运行

假设mirai和starbot均运行于docker中
先创建network
```
docker network create my_network
```
mirai的docker compose：
```
services:
  mirai:
    image: fall2wish/mirai-overflow-docker:latest
    container_name: mirai_overflow
    stdin_open: true
    tty: true
    restart: always
    ports:
      - 5800:5800  # 对外映射 5800 端口
    volumes:
      - $(pwd)/mirai_overflow:/home/mirai
    networks:
      - botnetwork
networks:
  botnetwork:
    external: true
    name: botnetwork
```
starbot的docker compose如下：
```
services:
  starbot:
    image: ghcr.io/book-fall2wish/starbot-docker:main
    container_name: starbot
    restart: always
    environment:
     - TZ=Asia/Shanghai
    volumes:
      - $(pwd)/app:/app
    networks:
      - botnetwork
      
networks:
  botnetwork:
    external: true
    name: botnetwork
```

mirai中setting.yml设置如下：
```
adapters:
  - http
  - ws
debug: false
enableVerify: true
verifyKey: StarBot
singleMode: false
cacheSize: 4096
persistenceFactory: 'built-in'
adapterSettings:
  ## 其中的 7827 为 StarBot 的默认连接端口，如需修改此处，请在启动 StarBot 时使用 config.set("MIRAI_PORT", 端口号) 同步修改
  http:
    host: 0.0.0.0
    port: 7827
    cors: ["*"]
    unreadQueueMaxSize: 100

  ## 其中的 7827 为 StarBot 的默认连接端口，如需修改此处，请在启动 StarBot 时使用 config.set("MIRAI_PORT", 端口号) 同步修改
  ws:
    host: 0.0.0.0
    port: 7827
    reservedSyncId: -1
```

starbot中main.py添加如下行：
```
config.set("MIRAI_HOST", "mirai_overflow")
```
其余设置与官方文档一致
