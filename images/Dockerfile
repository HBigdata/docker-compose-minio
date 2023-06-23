FROM registry.cn-hangzhou.aliyuncs.com/bigdata_cloudnative/centos-jdk:7.7.1908

# 创建日志存储目录
RUN mkdir -p /opt/apache/minio/logs
# 分别在三个节点上创建存储目录
RUN mkdir -p /opt/apache/minio/data/export{1..3}
# 创建配置目录
RUN mkdir -p /etc/minio
# 账号密码
ENV MINIO_ROOT_USER=admin
ENV MINIO_ROOT_PASSWORD=admin123456

# copy minio 
COPY minio /opt/apache/minio/

# copy minio client mc
COPY mc /opt/apache/minio/

RUN ln -s /opt/apache/minio/mc /usr/local/sbin/mc

# copy bootstrap.sh
COPY bootstrap.sh /opt/apache/
RUN chmod +x /opt/apache/bootstrap.sh

WORKDIR /opt/apache
