@[TOC]
## 一、概述
`MinIO` 是一个开源的**对象存储服务器**，它兼容`Amazon S3（Simple Storage Service）API`。它被设计用于构建分布式存储架构，提供高可用性、高性能和可扩展的对象存储解决方案。

下面是MinIO的一些主要特点和功能：

- **对象存储**：MinIO以对象为基本存储单元，可以存储和管理任意大小的文件、数据对象。它提供了标准的对象存储操作，如上传、下载、删除和元数据管理。

- **分布式架构**：MinIO采用分布式架构，可以在多个节点上部署，并将数据分布和复制在不同的节点上。这提供了高可用性和数据冗余，确保数据的持久性和可靠性。

- **高性能**：MinIO通过并行处理和分布式架构实现高性能的数据存取。它利用现代硬件和网络技术，充分利用多核处理器和高带宽网络，以实现快速的数据传输和处理。

- **水平扩展**：MinIO可以水平扩展，通过添加更多的节点来增加存储容量和吞吐量。它支持自动数据分片和负载均衡，确保数据在各个节点上均匀分布和访问的负载均衡。

- **数据保护**：MinIO提供了多种数据保护机制，包括数据冗余、故障转移和数据校验。它可以在不同的节点之间复制数据，以应对节点故障和数据损坏的情况。

- **安全性**：MinIO支持数据加密和访问控制，保护存储在其中的数据的安全性和隐私性。它提供了传输层加密（TLS/SSL）和服务器端加密选项，以及身份验证和访问控制机制。

总的来说，MinIO是一个开源的高性能对象存储服务器，适用于构建分布式存储系统。它具有高可用性、可扩展性和数据保护机制，兼容Amazon S3 API，使其与现有的S3生态系统和工具集成无缝。MinIO在大数据、云计算和容器化环境中广泛应用，为应用程序提供了可靠、高效的对象存储服务。

![输入图片说明](https://foruda.gitee.com/images/1687536100011026393/9a46d394_1350539.png "屏幕截图")

这里主要侧重使用docker快速部署环境，想了解更多，可以参考我以下几篇文章：

- [高性能分布式对象存储——MinIO（环境部署）](https://mp.weixin.qq.com/s?__biz=MzI3MDM5NjgwNg==&mid=2247487162&idx=1&sn=39c683a43ec2678fbf6d767f6ab6dcc6&chksm=ead0f253dda77b459edaf514cf72fc03546f2c5075c7b131c34b34772ca3517cab170d94c056#rd)
- [高性能分布式对象存储——MinIO实战操作（MinIO扩容）](https://mp.weixin.qq.com/s?__biz=MzI3MDM5NjgwNg==&mid=2247487196&idx=1&sn=5a3c8959977d31419969c572532dae08&chksm=ead0f235dda77b23173c212bb74b704f6b960d062cd8dfc25f3525d2209d174cb6727435e1ce#rd)
- [【云原生】Minio on k8s 讲解与实战操作](https://mp.weixin.qq.com/s?__biz=MzI3MDM5NjgwNg==&mid=2247486760&idx=1&sn=644809d0adafbcf839b78b9eea612bfd&chksm=ead0f1c1dda778d7e78a06dcb3fe699ea2fa845b3c761e27be260205508a949e15b2320aa301#rd)
- [【云原生.大数据】镜像仓库Harbor对接MinIO对象存储](https://mp.weixin.qq.com/s?__biz=MzI3MDM5NjgwNg==&mid=2247486309&idx=1&sn=67de788af13ac692db1802e93865e083&chksm=ead0f78cdda77e9ad18f3430e020c24149cf46b0198fea602d8640863fdde2a4c5b5ae0a0c79#rd)

官方文档：[https://docs.min.io/](https://docs.min.io/)
中文文档：[http://docs.minio.org.cn/docs/](http://docs.minio.org.cn/docs/)

## 二、MinIO 与 Ceph  对比

MinIO和Ceph都是流行的开源存储解决方案，它们在对象存储领域有不同的特点和适用场景。下面是MinIO和Ceph的对比：

### 1）架构设计对比

- **`MinIO`**：`MinIO`采用分布式架构，以水平扩展为基础。它通过多个独立的MinIO节点组成集群，每个节点都是独立的对象存储服务器。MinIO专注于提供简单、轻量级的对象存储服务，适用于小型到中等规模的部署。
- **`Ceph`**：`Ceph`是一个分布式存储系统，由对象存储、块存储和文件系统组成。它使用`RADOS（Reliable Autonomic Distributed Object Store）`作为底层存储系统，提供高可用性和数据冗余。Ceph适用于大规模的企业级部署，具有复杂的架构和丰富的功能。

### 2）数据一致性对比

- `MinIO`：`MinIO`在默认配置下提供最终一致性，即写入操作返回成功后，数据可能会有一定的时间窗口内的延迟才能完全一致。这适用于许多应用场景，如数据备份、存档等。
- `Ceph`：`Ceph`提供强一致性，即写入操作在返回成功后，数据即刻就达到一致性。这对于需要强一致性保证的应用场景非常重要，如数据库和事务处理。

### 3）部署和管理对比
- `MinIO`：`MinIO` 的部署和管理相对简单，可以通过单个二进制文件或容器进行快速安装和配置。它提供了直观的管理界面和易于使用的API，使得管理和监控变得简单。
- `Ceph`：`Ceph` 的部署和管理相对复杂，涉及多个组件和配置。它需要更多的时间和专业知识来设置和维护，需要熟悉Ceph的架构和配置。

### 4）生态系统和兼容性对比

- `MinIO`：MinIO与Amazon S3 API兼容，这意味着现有的S3工具和应用程序可以无缝地与MinIO集成。它还有一个活跃的社区，提供了各种客户端库和插件，扩展了其功能和兼容性。

- `Ceph`：`Ceph` 具有广泛的生态系统和丰富的功能集。它可以与多个协议和接口（如RADOS、RBD、CephFS）进行集成，提供块存储、文件系统和对象存储的全面解决方案。

综上所述，**MinIO适用于简单、轻量级的对象存储需求**，注重高性能和易用性。它适合中小规模部署，并且与Amazon S3兼容，易于与现有的S3生态系统集成。

- **`Ceph`则适用于大规模、复杂的企业级存储需求**。它提供强一致性和丰富的功能集，适合需要高可用性、数据冗余和复杂数据操作的场景。Ceph的部署和管理相对复杂，需要更多的配置和管理工作。

- 选择`MinIO`还是Ceph取决于具体的需求和场景。如果你需要一个简单、易用、高性能的对象存储解决方案，并与S3兼容，那么MinIO是一个不错的选择。如果你需要一个功能强大、可扩展、支持块存储和文件系统的分布式存储系统，且具备强一致性的要求，那么Ceph是更适合的选择。

无论选择MinIO还是Ceph，都需要仔细评估其与特定应用和环境的兼容性、性能需求、管理复杂性和可扩展性，以确保选择的解决方案能够满足实际需求并提供可靠的存储服务。

## 三、前期准备
### 1）部署 docker
```bash
# 安装yum-config-manager配置工具
yum -y install yum-utils

# 建议使用阿里云yum源：（推荐）
#yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

# 安装docker-ce版本
yum install -y docker-ce
# 启动并开机启动
systemctl enable --now docker
docker --version
```
### 2）部署 docker-compose
```bash
curl -SL https://github.com/docker/compose/releases/download/v2.16.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose
docker-compose --version
```
## 四、创建网络

```bash
# 创建，注意不能使用hadoop_network，要不然启动hs2服务的时候会有问题！！！
docker network create hadoop-network

# 查看
docker network ls
```
## 五、MinIO 编排部署
### 1）下载 MinIO 安装包
```bash
wget https://dl.min.io/server/minio/release/linux-amd64/minio
```
### 2）配置
这里部署的是伪集群，但是需要的磁盘还是那么多，下面就是挂载磁盘的步骤：

```bash
### 1、格式化
mkfs.ext4 /dev/sdb
mkfs.ext4 /dev/sdc
mkfs.ext4 /dev/sdd
mkfs.ext4 /dev/sde
mkfs.ext4 /dev/sdf
mkfs.ext4 /dev/sdg
mkfs.ext4 /dev/sdh
mkfs.ext4 /dev/sdi
mkfs.ext4 /dev/sdj
mkfs.ext4 /dev/sdk
mkfs.ext4 /dev/sdl
mkfs.ext4 /dev/sdm

### 2、创建挂载目录
mkdir /opt/apache/docker-compose-minio/data/minio-node{1..3}/data{1..4}

### 3、挂载
# minio-node1
mount /dev/sdb /opt/apache/docker-compose-minio/data/minio-node1/data1
mount /dev/sdc /opt/apache/docker-compose-minio/data/minio-node1/data2
mount /dev/sdd /opt/apache/docker-compose-minio/data/minio-node1/data3
mount /dev/sde /opt/apache/docker-compose-minio/data/minio-node1/data4

# minio-node2
mount /dev/sdf /opt/apache/docker-compose-minio/data/minio-node2/data1
mount /dev/sdg /opt/apache/docker-compose-minio/data/minio-node2/data2
mount /dev/sdh /opt/apache/docker-compose-minio/data/minio-node2/data3
mount /dev/sdi /opt/apache/docker-compose-minio/data/minio-node2/data4

# minio-node3
mount /dev/sdj /opt/apache/docker-compose-minio/data/minio-node3/data1
mount /dev/sdk /opt/apache/docker-compose-minio/data/minio-node3/data2
mount /dev/sdl /opt/apache/docker-compose-minio/data/minio-node3/data3
mount /dev/sdm /opt/apache/docker-compose-minio/data/minio-node3/data4

### 4、持久化配置
# minio-node1
echo "/dev/sdb /opt/apache/docker-compose-minio/data/minio-node1/data1  ext4  defaults        0 0" >> /etc/fstab
echo "/dev/sdc /opt/apache/docker-compose-minio/data/minio-node1/data2  ext4  defaults        0 0" >> /etc/fstab
echo "/dev/sdd /opt/apache/docker-compose-minio/data/minio-node1/data3  ext4  defaults        0 0" >> /etc/fstab
echo "/dev/sde /opt/apache/docker-compose-minio/data/minio-node1/data4  ext4  defaults        0 0" >> /etc/fstab

# minio-node2
echo "/dev/sdf /opt/apache/docker-compose-minio/data/minio-node2/data1  ext4  defaults        0 0" >> /etc/fstab
echo "/dev/sdg /opt/apache/docker-compose-minio/data/minio-node2/data2  ext4  defaults        0 0" >> /etc/fstab
echo "/dev/sdh /opt/apache/docker-compose-minio/data/minio-node2/data3  ext4  defaults        0 0" >> /etc/fstab
echo "/dev/sdi /opt/apache/docker-compose-minio/data/minio-node1/data4  ext4  defaults        0 0" >> /etc/fstab

# minio-node3
echo "/dev/sdj /opt/apache/docker-compose-minio/data/minio-node3/data1  ext4  defaults        0 0" >> /etc/fstab
echo "/dev/sdk /opt/apache/docker-compose-minio/data/minio-node3/data2  ext4  defaults        0 0" >> /etc/fstab
echo "/dev/sdl /opt/apache/docker-compose-minio/data/minio-node3/data3  ext4  defaults        0 0" >> /etc/fstab
echo "/dev/sdm /opt/apache/docker-compose-minio/data/minio-node3/data4  ext4  defaults        0 0" >> /etc/fstab
```

### 3）启动脚本 bootstrap.sh

```bash
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
```
Minio默认9000端口，在配置文件中加入–address “127.0.0.1:9029” 可更改端口

- `MINIO_ACCESS_KEY`：用户名，长度最小是5个字符
- `MINIO_SECRET_KEY`：密码，密码不能设置过于简单，不然minio会启动失败，长度最小是8个字符
- `–config-dir`：指定集群配置文件目录
- `–address`： api的端口，默认是`9000`
- `--console-address` ：web端口，默认随机

> 【温馨提示】磁盘大小必须>`1G`，这里我添加的是4*2G的盘
### 4）构建镜像 Dockerfile

```bash
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
```
开始构建镜像

```bash
docker build -t registry.cn-hangzhou.aliyuncs.com/bigdata_cloudnative/minio:20230619 . --no-cache --progress=plain

# 为了方便小伙伴下载即可使用，我这里将镜像文件推送到阿里云的镜像仓库
docker push registry.cn-hangzhou.aliyuncs.com/bigdata_cloudnative/minio:20230619

### 参数解释
# -t：指定镜像名称
# . ：当前目录Dockerfile
# -f：指定Dockerfile路径
#  --no-cache：不缓存
```
### 5）编排 docker-compose.yaml

```yaml
version: '3'
services:
  minio-node1:
    image: registry.cn-hangzhou.aliyuncs.com/bigdata_cloudnative/minio:20230619
    container_name: minio-node1
    hostname: minio-node1
    restart: always
    privileged: true
    env_file:
      - .env
    expose:
      - "${MinIO_PORT}"
    ports:
      - "${MinIO_HTTP_PORT}"
    volumes:
      - /opt/apache/docker-compose-minio/data/minio-node1/data1:/opt/apache/minio/data/export1
      - /opt/apache/docker-compose-minio/data/minio-node1/data2:/opt/apache/minio/data/export2
      - /opt/apache/docker-compose-minio/data/minio-node1/data3:/opt/apache/minio/data/export3
      - /opt/apache/docker-compose-minio/data/minio-node1/data4:/opt/apache/minio/data/export4
    command: ["sh","-c","/opt/apache/bootstrap.sh"]
    networks:
      - hadoop-network
    healthcheck:
      test: ["CMD-SHELL", "netstat -tnlp|grep :${MinIO_PORT} || exit 1"]
      interval: 10s
      timeout: 10s
      retries: 5
  minio-node2:
    image: registry.cn-hangzhou.aliyuncs.com/bigdata_cloudnative/minio:20230619
    container_name: minio-node2
    hostname: minio-node2
    restart: always
    privileged: true
    env_file:
      - .env
    expose:
      - "${MinIO_PORT}"
    ports:
      - "${MinIO_HTTP_PORT}"
    volumes:
      - /opt/apache/docker-compose-minio/data/minio-node2/data1:/opt/apache/minio/data/export1
      - /opt/apache/docker-compose-minio/data/minio-node2/data2:/opt/apache/minio/data/export2
      - /opt/apache/docker-compose-minio/data/minio-node2/data3:/opt/apache/minio/data/export3
      - /opt/apache/docker-compose-minio/data/minio-node2/data4:/opt/apache/minio/data/export4
    command: ["sh","-c","/opt/apache/bootstrap.sh"]
    networks:
      - hadoop-network
    healthcheck:
      test: ["CMD-SHELL", "netstat -tnlp|grep :${MinIO_PORT} || exit 1"]
      interval: 10s
      timeout: 10s
      retries: 5
  minio-node3:
    image: registry.cn-hangzhou.aliyuncs.com/bigdata_cloudnative/minio:20230619
    container_name: minio-node3
    hostname: minio-node3
    restart: always
    privileged: true
    env_file:
      - .env
    expose:
      - "${MinIO_PORT}"
    ports:
      - "${MinIO_HTTP_PORT}"
    volumes:
      - /opt/apache/docker-compose-minio/data/minio-node3/data1:/opt/apache/minio/data/export1
      - /opt/apache/docker-compose-minio/data/minio-node3/data2:/opt/apache/minio/data/export2
      - /opt/apache/docker-compose-minio/data/minio-node3/data3:/opt/apache/minio/data/export3
      - /opt/apache/docker-compose-minio/data/minio-node3/data4:/opt/apache/minio/data/export4
    command: ["sh","-c","/opt/apache/bootstrap.sh"]
    networks:
      - hadoop-network
    healthcheck:
      test: ["CMD-SHELL", "netstat -tnlp|grep :${MinIO_PORT} || exit 1"]
      interval: 10s
      timeout: 10s
      retries: 5

# 连接外部网络
networks:
  hadoop-network:
    external: true
```
`.env` 文件内容

```bash
MinIO_PORT=9000
MinIO_HTTP_PORT=9001
```
### 6）开始部署
```bash
# --project-name指定项目名称，默认是当前目录名称
docker-compose -f docker-compose.yaml up -d

# 查看
docker-compose -f docker-compose.yaml ps

# 卸载
docker-compose -f docker-compose.yaml down
```
### 7）简单测试验证

```bash
# 登录容器内测试
docker exec -it minio-node1 bash

# 登录，密文输入（推荐）
[root@minio-node1 apache]# mc config host add minio http://localhost:9000
Enter Access Key: admin
Enter Secret Key: 输入密码
Added `minio` successfully.

# 查看集群信息
mc admin info minio
```
![输入图片说明](https://foruda.gitee.com/images/1687536136143112714/8a049638_1350539.png "屏幕截图")

### 8）web 访问
`http://ip:port`

```bash
docker-compose -f docker-compose.yaml ps
```
账号/密码：`admin`/`admin123456`
![输入图片说明](https://foruda.gitee.com/images/1687536145569311412/8c06ee1c_1350539.png "屏幕截图")
![输入图片说明](https://foruda.gitee.com/images/1687536153920532821/30ec1b1c_1350539.png "屏幕截图")

---

到此通过 docker-compose 快速部署 MinIO 保姆级教程就完结了，有任何疑问请关注我公众号：`大数据与云原生技术分享`，加群交流或私信沟通，，如本篇文章对您有所帮助，麻烦帮忙一键三连（点赞、转发、收藏）~

![输入图片说明](https://foruda.gitee.com/images/1687535996904276100/9e1bfe6b_1350539.png "屏幕截图")