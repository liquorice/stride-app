= Stride App

Documentation for developers working with this project.

== Bundler

Bundler is used to manage Ruby dependencies. Run `bundle` to ensure dependencies are installed and up-to-date.

== Database

This project uses postgres. Install on OSX with homebrew, using `brew install postgresql`. You will need to create a user named `stride`, with password `stride`. This is done with:

`createuser stride --pwprompt -s`
(You will be prompted to enter the password)

To create the database (only required the first time you set up the app), use `rake db:create && rake db:migrate`. To migrate the database at any time to reflect new structural changes, use `rake db:migrate`.

== Sites

The app is deployed once, but is accessed as several different sites. This is determined by the request url, which is matched against the 'hosts' array in the Sites table.