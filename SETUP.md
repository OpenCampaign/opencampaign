OpenCampaign Setup
---

## Dot-Env FTW

Create a `<app_root>/.env` file that will specify all the environment variables
needed from `config/.env.example` (or you can set these variables in Heroku,
etc.)

## Database

Configure your `config/database.yml` based off of `config/database.yml.example`

## Create Roles

Run the following to create the needed roles for OpenCampaign to work properly:

`bundle exec rake roles:create`

## Create a User

Create an account by accessing the `/register` page and then add yourself as an admin by doing the following:

```
bundle exec rake roles:grant_admin[your_email]
```
