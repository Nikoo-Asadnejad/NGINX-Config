# Advanced Nginx Reverse Proxy with Load Balancing

This project provides a comprehensive configuration for Nginx as a reverse proxy with advanced features such as load balancing, caching, compression, rate limiting, and enhanced security. It supports both HTTP and HTTPS traffic, with HTTPS termination, custom error pages, and more.

---

## Features

- **Reverse Proxy**: Forward client requests to backend servers.
- **Load Balancing**: Distribute traffic among multiple backend servers with support for:
  - Round Robin (default)
  - Least Connections
  - IP Hash (sticky sessions)
- **SSL/TLS Support**: Secure connections with strong SSL/TLS configuration.
- **HTTP/2 Support**: Improved performance for modern web clients.
- **Caching**: Configurable caching for improved performance.
- **Rate Limiting**: Protect backend servers from abusive requests.
- **Compression**: Gzip compression for reduced bandwidth usage.
- **Security Headers**: Protect against common web vulnerabilities.
- **Custom Error Pages**: Enhanced user experience for error handling.

---

## Prerequisites

1. **Nginx Installed**:
   ```bash
   sudo apt update
   sudo apt install nginx

   
## Installation:

### Edit Nginx Configuration  : 
  Create a new configuration file for the reverse proxy and copy the configs in it.
```bash
sudo nano /etc/nginx/sites-available/load-balanced-reverse-proxy
```

###  Enable the Configuration :
```bash
sudo ln -s /etc/nginx/sites-available/load-balanced-reverse-proxy /etc/nginx/sites-enabled/
```

### Test and Restart Nginx : 
```bash
sudo nginx -t
sudo systemctl restart nginx
```

### Check Nginx Status :
```bash
sudo systemctl status nginx
```

### Review Logs : 
```bash
sudo tail -f /var/log/nginx/*.log
```

---------------------------------------------------------------------------------
# Run It with Docker 

## Run the container with volumes :
You can run the Nginx container with a volume mount to use your custom configuration without rebuilding the image:
```bash
docker run -d \
  --name nginx-proxy \
  -p 80:80 -p 443:443 \
  -v ~/nginx-config/load-balanced-reverse-proxy.conf:/etc/nginx/conf.d/default.conf:ro \
  -v ~/nginx-config/ssl:/etc/ssl:ro \
  -v ~/nginx-config/html:/var/www/html:ro \
  nginx:latest
```

## Use the Docker file for having custom image :
Needs rebuilding the image each time and it's not recommended.

## Use the Docker Compose.

Run the container:

```bash
docker-compose up -d
```

Check that the container is running:
```bash
docker ps
```

Test the configuration inside the container:
```bash
docker exec -it nginx-proxy nginx -t
```

Access the Nginx logs for debugging:
```bash
docker logs nginx-proxy
```

If you make changes to your Nginx configuration, reload it without restarting the container:
```bash
docker exec -it nginx-proxy nginx -s reload
```

 --------------------------------------------------------------------------------

### Load Balancing Methods :
Load Balancing Methods in Nginx

1.	Round Robin (default):
	-	Distributes client requests evenly across all available backend servers.
	-	Suitable for general-purpose load balancing without specific session persistence needs.
2.	Least Connections:
	-	Sends traffic to the backend server with the fewest active connections.
	-	Ideal for scenarios where servers have uneven processing capacities or traffic spikes.
3.	IP Hash:
  -	Routes requests from the same client IP to the same backend server (sticky sessions).
	-	Useful when session persistence is required, such as with stateful applications.

### Custom Error Pages :
```bash
echo "Page not found." | sudo tee /var/www/html/custom_404.html
echo "Something went wrong." | sudo tee /var/www/html/custom_50x.html
```




