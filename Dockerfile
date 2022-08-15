FROM node:16-alpine as builder

WORKDIR '/app'

COPY package.json .

RUN npm install

COPY . .

RUN npm run build
# /app/build

FROM nginx
# EXPOSE does not do anything, but is to notify devs that this container needs to have port 80 exposed
# added here, because per course, EBS will use this to open up the port for the hosted app
# however, with new versions of EBS, this is not necessary, and it is instead going to look for a docker-compose file; we have provided this file and handle the port mapping therein
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html