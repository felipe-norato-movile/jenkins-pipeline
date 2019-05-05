FROM node:8-alpine

RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-17.04.0-ce.tgz \
  && tar xzvf docker-17.04.0-ce.tgz \
  && mv docker/docker /usr/local/bin \
  && rm -r docker docker-17.04.0-ce.tgz

# Create application directory
ENV APP_HOME=app_testing
RUN mkdir ${APP_HOME}

WORKDIR /${APP_HOME}

# Install dependencies dependencies
ADD package*.json ./
RUN npm install

ENV PATH=./node_modules/.bin:$PATH
ADD . ./

# Run the application
EXPOSE 4200

CMD ["npm", "start"]
