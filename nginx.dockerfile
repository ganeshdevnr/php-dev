FROM nginx:stable-alpine

# Why am I creating this user and group
ENV NGINX_USER=developer
ENV NGINX_GROUP=developer

RUN addgroup -g 1000 ${NGINX_GROUP} && adduser -G ${NGINX_GROUP} -g ${NGINX_GROUP} -s /bin/sh -D ${NGINX_USER}

# Create directories for public, logs and cache
RUN mkdir -p /var/www/html/public \
    && mkdir -p /var/www/html/storage/logs \
    && mkdir -p /var/www/html/bootstrap/cache

# Change the owner for storage, logs and cache
RUN chown -R ${NGINX_USER}:${NGINX_GROUP} \
    /var/www/html/storage \
    /var/www/html/storage/logs \
    /var/www/html/bootstrap/cache

# Change the permissions for storage, logs and cache
RUN chmod -R 775 \
    /var/www/html/storage \
    /var/www/html/storage/logs \
    /var/www/html/bootstrap/cache

# Update Nginx user in nginx.conf
RUN sed -i "s/user nginx;/user ${NGINX_USER};/g" /etc/nginx/nginx.conf

# Add your Nginx config file
ADD nginx/default.conf /etc/nginx/conf.d/default.conf

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]






