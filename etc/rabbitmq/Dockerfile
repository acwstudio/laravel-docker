FROM rabbitmq:3-management-alpine
RUN apk add nano
COPY rabbitmq.conf /etc/rabbitmq/rabbitmq.conf
CMD [ "rabbitmq-server", "/etc/rabbitmq/rabbitmq.conf" ]
