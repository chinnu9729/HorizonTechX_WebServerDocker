
FROM nginx:alpine

WORKDIR /usr/share/nginx/html

COPY app/index.html /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
CMD wget --quiet --tries=1 --spider http://localhost/ || exit 1


CMD ["nginx", "-g", "daemon off;"]
