FROM cypress/included:12.2.0

WORKDIR /e2e

RUN npm i --location=global cypress-visual-regression@2.1.0
RUN ln -s /usr/local/lib/node_modules /node_modules # webpack hack: for some reason, NODE_PATH is ignored by webpack