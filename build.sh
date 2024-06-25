chmod +x armv7l/query-engine
chmod +x armv7l/schema-engine
docker build -t try-armv7l-migpt-server --platform=linux/armv7l .
