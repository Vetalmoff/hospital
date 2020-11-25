# README

Hospital app

This is a simple application where you can to do an appointment to a doctor.
It checks if new slot (it consists of two parameters: start time, end time.
And has two constraints: each timeslot's duration is multiply of 5 minutes and should
be less or equals 30 minutes)
can be added without conflict into existing timeslots,
and add your time slot to existing if it is possible.
If it isn't possible, this app will give you two recommended time slots,
as you want, that are nearest available.

There are few steps are necessary to get the application up and running.

You should :

* Install ruby(version 2.6.6)
* Install node js version 14.15.0
* Install MySQL 
* Create some directory and clone this repository into it
* Enter created directory and run bundle install
* If you receive error message like this: "Your Yarn packages are out of date!"
  Please run in your terminal `yarn install --check-files` to update
*Than go to the file config/database.yml and change `username:` and `password:` 
    to yours db configuration parameters, in order to have access to your database.
* Run `rails db:create` to create data bases in your application
* Run `rails db:migrate` to create tables and dependencies
* If you want run `rails db:seed` to create some doctors and users
* Final step: run `rails s` to start server

And there we go!!!

If you want to play with this app, look into the folder db/seeds.rb,
    there are some users with admin permission. You can use them(login with that email and password)
    to have access in this application.

If you want run the tests, simply run `bundle exec rspec spec/`


Thanks for reading!
