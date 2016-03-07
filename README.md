= Stride App

Documentation for developers working with this project.

== Bundler

Bundler is used to manage Ruby dependencies. Run `bundle` to ensure dependencies are installed and up-to-date.

== Database

This project uses postgres. Install on OSX with homebrew, using `brew install postgresql`. You will need to create a user named `stride`, with password `stride`. This is done with:

`createuser stride --pwprompt -s`
(You will be prompted to enter the password)

To create the database (only required the first time you set up the app), use `rake db:create && rake db:migrate`. To migrate the database at any time to reflect new structural changes, use `rake db:migrate`.

=== Fixtures

Fixtures contain meaningful data for testing, and are kept up-to-date as a record of the data required to use and test the app. To load the data from fixtures into the development database (which will overwrite any existing data) run `rake db:fixtures:load`

== Sites

The app is deployed once, but is accessed as several different sites. This is determined by the request url, which is matched against the 'hosts' array in the Sites table.

The app will 404 if a matching site is not found. In development, use `pow` to create the sites for pete and dale. Follow the instructions on http://pow.cx/ to install pow, then set-up the two sites with:

    ln -s ~/PATH/TO/APP ~/.pow/dale-app
    ln -s ~/PATH/TO/APP ~/.pow/pete-app

You should then be able to access `http://pete-app.dev` and `http://dale-app.dev`.

