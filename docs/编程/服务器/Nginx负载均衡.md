

## Nginx配置

```nginx
http {
    keepalive_timeout  65;
    
    upstream upstream_name{
        server 192.168.0.28:8001;
        server 192.168.0.28:8002;
    }

    server {
        listen       8080;
        server_name  localhost;

        location / {
            proxy_pass http://upstream_name;#请求转向upstream_name定义的服务器列表
            proxy_set_header Host $host;#将请求头转发给后端服务器
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;#后端的Web服务器可以通过X-Forwarded-For获取用户真实IP
            #client_max_body_size 10m;#允许客户端请求的最大单文件字节数
            #client_body_buffer_size 128k;#缓冲区代理缓冲用户端请求的最大字节数
            #proxy_connect_timeout 90;#nginx跟后端服务器连接超时时间(代理连接超时)
            #proxy_send_timeout 90;#后端服务器数据回传时间(代理发送超时)
            #proxy_read_timeout 90;#连接成功后，后端服务器响应时间(代理接收超时)
            #proxy_buffer_size 4k;#设置代理服务器（nginx）保存用户头信息的缓冲区大小
            #proxy_buffers 4 32k;#proxy_buffers缓冲区，网页平均在32k以下的话，这样设置
            #proxy_busy_buffers_size 64k;#高负荷下缓冲大小（proxy_buffers*2）
            #proxy_temp_file_write_size 64k;#设定缓存文件夹大小，大于这个值，将从upstream服务器传
        }
    }
}
```



## Nginx负载均衡策略

### 1 轮询（默认）

| 参数         | 描述                                                         |
| ------------ | ------------------------------------------------------------ |
| fail_timeout | 与max_fails结合使用                                          |
| max_fails    | 设置在fail_timeout参数设置的时间内最大失败次数，如果在这个时间内，所有针对该服务器的请求都失败了，那么认为该服务器会被认为是停机了 |
| fail_time    | 服务器会被认为停机的时间长度,默认为10s。                     |
| backup       | 标记该服务器为备用服务器。当主服务器停止时，请求会被发送到它这里。 |
| down         | 标记服务器永久停机了。                                       |

```nginx
 upstream upstream_name{
     server 192.168.0.28:8001;
     server 192.168.0.28:8002;
 }
```

### 2 权重

通过weight参数制定轮询的几率，weight默认为1

```nginx
upstream foo {
    server localhost:8001 weight=2;
    server localhost:8002;
    server localhost:8003 backup;
    server localhost:8004 max_fails=3 fail_timeout=20s;
}
```

### 3 ip_hash

通过对ip进行hash，确保同一个客户端请求一直落在相同服务器上

```nginx
upstream foo {
    ip_hash;
    server localhost:8001 weight=2;
    server localhost:8002;
    server localhost:8003;
    server localhost:8004 max_fails=3 fail_timeout=20s;
}
```

### 4 **least_conn**  最小连接

把请求转发给连接数较少的后端服务器

```nginx
upstream foo {
    least_conn;
    server localhost:8001 weight=2;
    server localhost:8002;
    server localhost:8003 backup;
    server localhost:8004 max_fails=3 fail_timeout=20s;
}
```

