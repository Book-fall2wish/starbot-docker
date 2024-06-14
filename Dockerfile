# 使用 Python 3.10 作为基础镜像
FROM python:3.10-slim

# 设置环境变量
ENV PYTHONUNBUFFERED=1

# 安装 Redis 和相关依赖
RUN apt-get update && \
    apt-get install -y redis-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 创建一个目录来存放main.py
WORKDIR /app

# 安装 starbot-bilibili
RUN pip install --no-cache-dir starbot-bilibili

# 复制启动脚本到 /usr/local/bin 并赋予执行权限
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# 设置容器启动时运行的命令
CMD ["/usr/local/bin/start.sh"]
