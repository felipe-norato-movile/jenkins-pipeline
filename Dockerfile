FROM node:8-alpine


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
