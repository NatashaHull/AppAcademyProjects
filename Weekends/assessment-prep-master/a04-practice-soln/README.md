# Assessment 4 - practice

This assessment will focus on a simple CRUD app with authentication.

You will have to model users, links, and comments, along with session
management.

The specs all test high-level functionality in your app. Take a look at
them as you go to ensure you are naming your links, buttons, and routes
correctly.

Good luck!

## Database Config
Every time you run `rake db:migrate` run `rake db:test:prepare`.

## Tests order

* `bundle exec rspec spec/features/auth_spec.rb`
* `bundle exec rspec spec/features/links_spec.rb`
* `bundle exec rspec spec/features/comments_spec.rb`
* SecureRandom::urlsafe_base64
* form_authenticity_token
* password too short
* button text
* debubger