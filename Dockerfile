FROM python:3.10

ENV TZ Asia/Shanghai
ENV BASE_PATH=/home/starbot
WORKDIR $BASE_PATH
ENTRYPOINT ["/usr/bin/redis-server"]

# 安装所需的工具
RUN apt update && apt install redis-server -y && \
    pip install starbot-bilibili

# 将交互脚本复制到镜像中
# COPY 推送配置.json /home/starbot/推送配置.json
# 需要在映射目录下保存推送配置.json和main.py
COPY wait-for-redis.sh /usr/src/app/
RUN chmod +x /usr/src/app/wait-for-redis.sh

CMD /usr/src/app/wait-for-redis.sh && python main.py
