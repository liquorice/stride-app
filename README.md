# Stride App

Documentation for developers working with this project.

## Bundler

Bundler is used to manage Ruby dependencies. Run `bundle` to ensure dependencies are installed and up-to-date.

## Database

This project uses postgres. Install on OSX with homebrew, using `brew install postgresql`. You will need to create a user named `stride`, with password `stride`. This is done with:

`createuser stride --pwprompt -s`
(You will be prompted to enter the password)

To create the database (only required the first time you set up the app), use `rake db:create && rake db:migrate`. To migrate the database at any time to reflect new structural changes, use `rake db:migrate`.

### Fixtures

Fixtures contain meaningful data for testing, and are kept up-to-date as a record of the data required to use and test the app. To load the data from fixtures into the development database (which will overwrite any existing data) run `rake db:fixtures:load`

## Sites

The app is deployed once, but is accessed as several different sites. This is determined by the request url, which is matched against the 'hosts' array in the Sites table.

The app will 404 if a matching site is not found. In development, use `pow` to create the sites for pete and dale. Follow the instructions on http://pow.cx/ to install pow, then set-up the two sites with:

    ln -s ~/PATH/TO/APP ~/.pow/dale-app
    ln -s ~/PATH/TO/APP ~/.pow/pete-app

You should then be able to access `http://pete-app.dev` and `http://dale-app.dev`.

## Access Control

To restrict access to parts of the app, we maintain a set of possible permission privledges. These are stored in `config/access_permissions.yml`. Each key is the symbol that can be checked through code; and the value is the human-friendly description of the permission displayed in the admin interface. These are available at run time as `AccessLevel.permissions_list`.

Each `user` inherits their `permissions` through their `access_level`, defaulting to no permissions. To check if a user has a specific permission, you can use `can?`:

`@current_user.can? :accessLevel_modify`

When requiring a particular permission within a controller, you can use `require_permission`:

    def index
      require_permission :accessLevels_modify
      @access_levels = @site.access_levels
    end

Be sure to `require_permission` on all associated actions, not just those that control the display of the form.

### Superuser

Superusers have access to the entire app, and sidestep all permission checks. The superuser property on a user can only be set via the `console`; there is no web-based control. This ensures that superuser status can not be set without express intervention from a developer.