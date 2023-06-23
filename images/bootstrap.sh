#!/bin/bash
source /etc/profile

# 在三台机器上都执行该文件，即以分布式的方式启动了MINIO
# --address "0.0.0.0:9000" 挂载9001端口为api端口（如Java客户端）访问的端口
# --console-address ":9000" 挂载9000端口为web端口；
/opt/apache/minio/minio server --address 0.0.0.0:9000 --console-address 0.0.0.0:9001 --config-dir /etc/minio \
http://minio-node1/opt/apache/minio/data/export1 \
http://minio-node1/opt/apache/minio/data/export2 \
http://minio-node1/opt/apache/minio/data/export3 \
http://minio-node1/opt/apache/minio/data/export4 \
http://minio-node2/opt/apache/minio/data/export1 \
http://minio-node2/opt/apache/minio/data/export2 \
http://minio-node2/opt/apache/minio/data/export3 \
http://minio-node2/opt/apache/minio/data/export4 \
http://minio-node3/opt/apache/minio/data/export1 \
http://minio-node3/opt/apache/minio/data/export2 \
http://minio-node3/opt/apache/minio/data/export3 \
http://minio-node3/opt/apache/minio/data/export4 >/opt/apache/minio/logs/minio_server.log &

tail -f /opt/apache/minio/logs/minio_server.log
