在给 migpt-server 打包 armv7l 的镜像时出错了。

运行 `sh build.sh` 时，出现了以下错误：

```
64.28 npm ERR! code 1
64.28 npm ERR! path /usr/local/lib/node_modules/migpt-server/node_modules/mi-gpt
64.29 npm ERR! command failed
64.29 npm ERR! command sh -c npx -y prisma migrate dev --name hello
64.29 npm ERR! Prisma schema loaded from prisma/schema.prisma
64.29 npm ERR! Datasource "db": SQLite database "app.db" at "file:app.db"
64.29 npm ERR! 
64.29 npm ERR! SQLite database app.db created at file:app.db
64.29 npm ERR! 
64.29 npm ERR! Applying migration `20240227161545_init`
64.29 npm ERR! 
64.29 npm ERR! The following migration(s) have been applied:
64.29 npm ERR! 
64.29 npm ERR! migrations/
64.29 npm ERR!   └─ 20240227161545_init/
64.29 npm ERR!     └─ migration.sql
64.30 npm ERR! prisma:warn Prisma only officially supports Linux on amd64 (x86_64) and arm64 (aarch64) system architectures (detected "arm" instead). If you are using your own custom Prisma engines, you can ignore this warning, as long as you've compiled the engines for your system architecture "armv7l".
64.30 npm ERR! prisma:warn Prisma only officially supports Linux on amd64 (x86_64) and arm64 (aarch64) system architectures (detected "arm" instead). If you are using your own custom Prisma engines, you can ignore this warning, as long as you've compiled the engines for your system architecture "armv7l".
64.30 npm ERR! Error: Error in RPC
64.30 npm ERR!  Request: {
64.30 npm ERR!   "id": 3,
64.30 npm ERR!   "jsonrpc": "2.0",
64.30 npm ERR!   "method": "evaluateDataLoss",
64.30 npm ERR!   "params": {
64.30 npm ERR!     "migrationsDirectoryPath": "/usr/local/lib/node_modules/migpt-server/node_modules/mi-gpt/prisma/migrations",
64.30 npm ERR!     "schema": {
64.30 npm ERR!       "files": [
64.30 npm ERR!         {
64.30 npm ERR!           "path": "/usr/local/lib/node_modules/migpt-server/node_modules/mi-gpt/prisma/schema.prisma",
64.30 npm ERR!           "content": "// This is your Prisma schema file,\n// learn more about it in the docs: https://pris.ly/d/prisma-schema\n\ngenerator client {\n  provider = \"prisma-client-js\"\n}\n\ndatasource db {\n  provider = \"sqlite\"\n  url      = \"file:app.db\"\n}\n\nmodel User {\n  id                String            @id @default(uuid())\n  name              String\n  profile           String\n  // 关联数据\n  rooms             Roo           @relation(\"RoomMembers\")\n  messages          Message[]\n  memories          Memory[]\n  shortTermMemories ShortTermMemory[]\n  longTermMemories  LongTermMemory[]\n  // 时间日期\n  createdAt         DateTime      @default(now())\n  updatedAt         DateTime          @updatedAt\n}\n\nmodel Room {\n  id                String            @id @default(uuid())\n  name              String\n  description       String\n  // 关联数据\n  membe         User[]            @relation(\"RoomMembers\")\n  messages          Message[]\n  memories          Memory[]\n  shortTermMemories ShortTermMemory[]\n  longTermMemories  LongTermMemory[]\n  // 时间日期\n  createdAt      ateTime          @default(now())\n  updatedAt         DateTime          @updatedAt\n}\n\nmodel Message {\n  id        Int      @id @default(autoincrement())\n  text      String\n  // 关联数据\n  sender    User     @relation(fs: [senderId], references: [id])\n  senderId  String\n  room      Room     @relation(fields: [roomId], references: [id])\n  roomId    String\n  memories  Memory[]\n  // 时间日期\n  createdAt DateTime @default(now())\n  updateDateTime @updatedAt\n}\n\nmodel Memory {\n  id                Int               @id @default(autoincrement())\n  // 关联数据\n  msg               Message           @relation(fields: [msgId], references: [id])\n  msgId         Int\n  owner             User?             @relation(fields: [ownerId], references: [id]) // owner 为空时，即房间自己的公共记忆\n  ownerId           String?\n  room              Room              @relation(fields: [roomId], d])\n  roomId            String\n  shortTermMemories ShortTermMemory[]\n  // 时间日期\n  createdAt         DateTime          @default(now())\n  updatedAt         DateTime          @updatedAt\n}\n\nmodel ShortTermMemory {\n  i            Int              @id @default(autoincrement())\n  text             String\n  // 关联数据\n  cursor           Memory           @relation(fields: [cursorId], references: [id]) // 记忆最后更新的位置\n  cursorId       owner            User?            @relation(fields: [ownerId], references: [id]) // owner 为空时，即房间自己的公共记忆\n  ownerId          String?\n  room             Room             @relation(fields: [roomId], references: d           String\n  longTermMemories LongTermMemory[]\n  // 时间日期\n  createdAt        DateTime         @default(now())\n  updatedAt        DateTime         @updatedAt\n}\n\nmodel LongTermMemory {\n  id        Int         @id @default(autoincrement())\n  text      String\n  // 关联数据\n  cursor    ShortTermMemory @relation(fields: [cursorId], references: [id])\n  cursorId  Int\n  owner     User?           @relation(fields: [ownerId], referen [id]) // owner 为空时，即房间自己的公共记忆\n  ownerId   String?\n  room      Room            @relation(fields: [roomId], references: [id])\n  roomId    String\n  // 时间日期\n  createdAt DateTime        @default(now())\n  updatedAt DateTime        @updatedAt\n}\n"
64.30 npm ERR!         }
64.30 npm ERR!       ]
64.30 npm ERR!     }
64.30 npm ERR!   }
64.30 npm ERR! }
64.30 npm ERR! Response: {
64.30 npm ERR!   "jsonrpc": "2.0",
64.30 npm ERR!   "error": {
64.30 npm ERR!     "code": -32602,
64.30 npm ERR!     "message": "Invalid params: missing field `prismaSchema`."
64.30 npm ERR!   },
64.30 npm ERR!   "id": 3
64.30 npm ERR! }
64.30 npm ERR! Invalid params: missing field `prismaSchema`.
64.31 
64.31 npm ERR! A complete log of this run can be found in: /root/.npm/_logs/2024-06-25T05_23_20_450Z-debug-0.log
------
Dockerfile:25
--------------------
  23 |     COPY . .
  24 |     
  25 | >>> RUN npm install -g migpt-server
  26 |     EXPOSE 36592
  27 |     ENTRYPOINT ["migpt-server"]
--------------------
ERROR: failed to solve: process "/bin/sh -c npm install -g migpt-server" did not complete successfully: exit code: 1
```
