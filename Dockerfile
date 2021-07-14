ROM node:12.2

ENV HOME=/home/app
ENV API_KEY=4ee009c16c55367cf3c9059be7053b9f

RUN apt-get update && apt-get install htop

COPY package.json package-lock.json $HOME/node_docker/

WORKDIR $HOME/node_docker

RUN npm install --silent --progress=false

COPY . $HOME/node_docker

CMD ["npm", "start"]
