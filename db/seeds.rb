# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
site = nil
case Rails.env
when 'development'
  site = Site.create(name: 'dale', hosts:['dale-app.dev'])
when 'production'
  site = Site.create(name: 'dale', hosts:['dale.org.au'])
end

user                 = User.create(site: site, name: 'admin', email:'james.dantes@reinteractive.com', superuser: true, password_digest: BCrypt::Password.create("Test1234"))
access_level         = AccessLevel.create(site: nil, name: "administrator", permissions_data: AccessLevel.permissions_list, ordinal: 5)
general_access_level = AccessLevel.create(site: site, name: "administrator",
                                          permissions_data: AccessLevel.permissions_list.slice("user_changeEmail", "forums_modify", "topics_create", "topics_modify", "topicThreads_create", "post_create", "message_create", "preferences_modify"), ordinal: 1)
user.access_level    = access_level
user.save!