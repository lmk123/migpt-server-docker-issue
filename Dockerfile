# arm32v7/node:20.15.0-alpine3.20 获取不到 metadata 报错
# arm32v7/node:20.15.0 虽然在 docker hub 的描述里是有这个 tag 的，但是实际 build 镜像时会报错 docker.io/arm32v7/node:20.15.0: not found
# arm32v7/node:20.14.0-alpine3.20 会卡在 npm install 阶段，没有任何日志输出，但也不报错。测试过，带有 alpine 的镜像都有这个问题。
# arm32v7/node:20.14.0 只有这个才是正常。
# 神奇了，才过了两个小时，arm32v7/node:20.14.0 也不正常了，确认过了无论是否开启 use containerd 都会报错，需要再往下降级版本。
FROM arm32v7/node:20.13.0

# prisma 官方不提供 armv7 架构的二进制文件，所以这里需要阻止它在找不到二进制文件时报错
ENV PRISMA_ENGINES_CHECKSUM_IGNORE_MISSING=1

# 以下三个环境变量，即使开启了也会报同样的错误
#ENV PRISMA_GENERATE_SKIP_AUTOINSTALL=1
#ENV PRISMA_SKIP_POSTINSTALL_GENERATE=1
#ENV PRISMA_GENERATE_NO_ENGINE=1

# 设置 armv7l 架构的 prisma 二进制文件路径
ENV PRISMA_QUERY_ENGINE_BINARY=/app/armv7l/query-engine-linux-armv7l
ENV PRISMA_QUERY_ENGINE_LIBRARY=/app/armv7l/libquery_engine-linux-armv7l.so.node
ENV PRISMA_SCHEMA_ENGINE_BINARY=/app/armv7l/schema-engine-linux-armv7l

# 把 armv7l 架构的 prisma 二进制文件拷贝到 /app 目录下
# 注意：其中的 query-engine 和 schema-engine 必须提前赋予可执行权限，即 `chmod +x query-engine`
WORKDIR /app
COPY . .
COPY ./armv7l /usr/local/lib/node_modules/migpt-server/node_modules/.prisma/client

#CMD ["echo", "done"]
# 这里要等 1 分钟左右
RUN npm install -g migpt-server
EXPOSE 36592
ENTRYPOINT ["migpt-server"]
