chmod +x armv7l/query-engine-linux-armv7l
chmod +x armv7l/schema-engine-linux-armv7l
docker build -t try-armv7l-migpt-server --platform=linux/arm/v7 .
