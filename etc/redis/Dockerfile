FROM redis:alpine
COPY etc/redis/redis.conf /usr/local/etc/redis/redis.conf
#RUN echo "PWD is: $PWD"
CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]
