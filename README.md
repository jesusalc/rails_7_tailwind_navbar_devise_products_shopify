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


    shopify login --store=gmbh-teststore

    cp .env.sample .env
    nano .env
    # add all the values for your store 

    rails s
    rm db/development.sqlite3 db/test.sqlite3 ; rake db:create db:migrate db:seed
    # browser opens and asks for confirmation of first user
    # control c
    rails s

