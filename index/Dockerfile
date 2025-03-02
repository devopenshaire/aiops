# Start with an official Nginx base image
FROM nginx:alpine

COPY generate_index.sh /generate_index.sh

# Make the script executable
RUN chmod +x /generate_index.sh

# Run the script to generate index.html before starting Nginx
CMD ["/bin/sh", "-c", "/generate_index.sh && nginx -g 'daemon off;'"]
