# Hysteria2 in docker
完整配置参考Hysteria2 Docs https://v2.hysteria.network/zh/

## 使用docker-compose部署
```yaml
version: '3.9'
services:
  hysteria:
    image: liyuanbiao/hysteria:latest
    container_name: hysteria2
    restart: unless-stopped
    network_mode: host
    volumes:
      - ./config.yaml:/etc/hysteria/server.yaml
      - /etc/letsencrypt/:/etc/letsencrypt/
    command: server -c /etc/hysteria/server.yaml
```

## 使用docker部署
```shell
docker run -d --name hysteria2 \
  --restart unless-stopped \
  --net host \
  -v ./config.yaml:/etc/hysteria/server.yaml \
  -v /etc/letsencrypt/:/etc/letsencrypt/ \
  liyuanbiao/hysteria:latest server -c /etc/hysteria/server.yaml
```

## 服务端 config
```yaml
listen: :8443 

# 替换成自己的证书
tls:
  cert: /etc/letsencrypt/live/example.com/fullchain.pem 
  key: /etc/letsencrypt/live/example.com/privkey.pem

auth:
  type: password
  password: WykDPYbZjR7b9QMsEFWj # 自定义密码

masquerade: 
  type: proxy
  proxy:
    url: https://www.bilibili.com/ 
    rewriteHost: true

acl:
  inline: 
    - reject(all, udp/443)
    - reject(geoip:cn)

```

## 客户端 config
```yaml
# 更改成你的IP或域名
server: example.com:8443 

auth: WykDPYbZjR7b9QMsEFWj 

bandwidth: 
  up: 20 mbps
  down: 100 mbps

socks5:
  listen: 127.0.0.1:1080 

http:
  listen: 127.0.0.1:8080 

```


