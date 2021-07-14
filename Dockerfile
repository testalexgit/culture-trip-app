FROM node:12.2

ENV HOME=/home/app
ENV API_KEY=123

RUN apt-get update && apt-get install htop

COPY package.json package-lock.json $HOME/node_docker/

WORKDIR $HOME/node_docker



COPY . $HOME/node_docker

CMD ["npm", "start"]
