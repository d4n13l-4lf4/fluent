FROM --platform=linux/arm64 arm64v8/node:iron-bullseye AS build

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm i -g npm@10.5.0
RUN npm ci --ignore-scripts

COPY . ./

RUN npm run build --omit=dev && npm prune --production

FROM --platform=linux/arm64 arm64v8/node:iron-slim

ENV PORT=3000
ENV NODE_ENV=production
WORKDIR /usr/app

COPY --from=build /usr/src/app/dist /usr/app/dist
COPY --from=build /usr/src/app/node_modules /usr/app/node_modules
RUN rm -rf /usr/app/dist/migrations/*.d.ts /usr/app/dist/migrations/*.map
COPY --from=build /usr/src/app/package.json /usr/app/package.json

EXPOSE 3000
ENTRYPOINT ["npm"]
CMD ["run", "start:prod"]
