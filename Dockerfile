# Build phase - use node:alpine image
FROM node:alpine as builder 

# Build phase - set app directory
WORKDIR '/app'

# Build phase - copy dependencies
COPY package.json .
RUN npm install
COPY . .

# Build phase - run commands 
RUN npm run build

# Copy phase - use nginx and copy from build phase
# Default command for nginx is to start up nginx, no 
# need to spcify command.
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html