require 'faker'

FactoryGirl.define do
   factory :wiki do
     title Faker::Book.title
     body Faker::Book.author
     private false
     user
   end
 end
