require 'rails_helper'
require 'faker'

RSpec.describe Wiki, type: :model do

   let(:title) { Faker::Book.title }
   let(:body) { Faker::Book.author }
   let(:private) { false }
   let(:user) { create :user }
   let(:wiki) { Wiki.create!(title: title, body: body, private: private, user: user) }

   describe "attributes" do
     it "has title, body, private, and user attributes" do
       expect(wiki).to have_attributes(title: title, body: body, private: private, user: user)
     end

     it "private is false by default" do
       expect(wiki.private).to be(false)
     end
   end
end
