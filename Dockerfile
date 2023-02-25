# alpineじゃないほうがいいかも
FROM node:14-alpine

ENV HOME /home
WORKDIR /app

# Install AWS CLI
# npm install cdkはしないのか？
RUN apk update && apk add aws-cli git chromium

COPY package.json yarn.lock ./

# package または service を追加したらここにも追加してください
# COPY pipeline/package.json ./pipeline/
# COPY packages/config/package.json ./packages/config/
# COPY packages/infra_lib/package.json ./packages/infra_lib/
# COPY packages/tsconfig/package.json ./packages/tsconfig/
# COPY services/download_pdf/infra/package.json ./services/download_pdf/infra/
# COPY services/download_pdf/lambda/package.json ./services/download_pdf/lambda/
# COPY services/billing_notification/infra/package.json ./services/billing_notification/infra/
# COPY services/billing_notification/lambda/package.json ./services/billing_notification/lambda/
# COPY services/iam/package.json ./services/iam/
# COPY services/github_actions/package.json ./services/github_actions/
# COPY services/planning_poker/package.json ./services/planning_poker/

# RUN yarn install --frozen-lockfile