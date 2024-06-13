#!/bin/bash

# 启动 Redis 服务
redis-server --daemonize yes

# 启动 Python 程序
python main.py
