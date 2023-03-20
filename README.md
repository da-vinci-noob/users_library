# User Files Library
A Rails App with VueJS as frontend framework integrated.
User Cloud Library with Private/Public files feature

## Setup

1. Install and Setup Docker if not already
2. Clone Repo `https://github.com/da-vinci-noob/users_library.git`
3. RUN `docker-compose run web ./bin/setup` to setup Project DB's and installations. 
4. RUN `docker-compose up` to start services.

## Setup If using without Docker.
> ### Prerequisite
> > Postgres Database, Ruby 3.2.1
1. Setup Prerequisites.
2. Clone Repo
3. Add below ENV Vars to `.env` file.
```
DB_HOST: Postgresql Hostname
DB_PASSWORD: Postgresql User
DB_USER: Postgresql Password
DEVISE_JWT_SECRET_KEY: generate using 'rake secret'
```
4. RUN `./bin/setup` to setup Project DB's and installations
5. RUN `./bin/dev` to run the server.


## Features
* User Accounts
* Upload Files.
* Change Password
* Private/Public Files.
* Copy Public Files
* Create user using rake task.
`docker-compose run web rake user:create`

---
## To Contribute (Add new Feature, Improve Something )

- Fork the project repository
- Clone your fork
- Navigate to your local repository
- Check that your fork is the 'origin' remote by:
  > `git remote -v`
  - if not add 'origin' remote by:
    > `git remote add origin <URL_OF_YOUR_FORK>`
- Add the project repository as the 'upstream' remote by:
  > `git remote add upstream <URL_OF_THIS_PROJECT>`
- Check that you now have two remotes: an origin that points to your fork, and an upstream that points to the project repository by:
  > `git remote -v`
- Pull the latest changes from upstream into your local repository.
  > `git pull upstream main`
- Create a new branch
  > `git checkout -b BRANCH_NAME`
- Make changes in your local repository
- Commit your changes
- Push your changes to your fork
  > `git push origin BRANCH_NAME`
- Create Pull Request
  > baseRepo - base:main <- yourRepo - compare:BRANCH_NAME
- Add Your description, Add any Images/Videos if required and Submit PR.
- You can add more commits/comments to the PR.
- You can delete the Branch (BRANCH_NAME) after your PR has been accepted and merged
- Sync your local Fork Repo to Updated Project Repo.

  > `git pull upstream main`

  > `git push origin main`

---

Made with :heart: and ![Ruby](https://img.shields.io/badge/-Ruby-000000?style=flat&logo=ruby)
