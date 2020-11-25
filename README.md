# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

Hospital app

This is a simple application where you can to do an appointment to a doctor.
It checks if new slot (it consists of two parameters: start time, end time.
And has two constraints: each timeslot's duration is multiply of 5 minutes and should
be less or equals 30 minutes)
can be added without conflict into existing timeslots,
and add your time slot to existing if it is possible.
If it isn't possible, this app will give you two recommended time slots,
as you want, that are nearest available.


Thanks!
