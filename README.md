# ZIP Deploy Action
This action creates a zip file of a repository and upload it to a server and then unzip it in a specified location
## Usage
```
name: CI
on:
  push:
    branches:
    - master
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@master
      - name: Deploy
        uses: y0ke/ZIP-Deploy-Action@master
        env:
          LOCAL_DIR: DIRECTORY_TO_DEPLOY
          REMOTE_DIR: REMOTE_DIR_TO_PUT
          EXCLUDE: "tests/* .gitattributes .gitignore"
          TARGET_SERVER: ${{ secrets.SERVER_NAME }}
          DEPLOY_USERNAME: ${{ secrets.DEPLOY_USERNAME }}
          DEPLOY_PASSWORD: ${{ secrets.DEPLOY_PASSWORD }}
          EXTRA_COMMANDS: ${{ secrets.DEPLOY_EXTRA_COMMANDS }}
```
