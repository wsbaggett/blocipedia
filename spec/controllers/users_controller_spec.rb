require 'rails_helper'

RSpec.describe UsersController, type: :controller do

let(:user) { create(:user) }

  before :each do
    sign_in user
  end

  describe "GET show" do

     it "renders the #show view" do
       get :show, id: user.id
       expect(response).to render_template :show
     end
     it "assigns current_user to @user" do
       get :show, {id: user.id}
       expect(assigns(:user)).to eq(user)
     end
   end

   describe "PUT downgrade" do
     it "assigns current_user to @user" do
       put :downgrade, {id: user.id}
       expect(assigns(:user)).to eq(user)
     end

     it "updates current_user account role to standard" do
       put :downgrade, {id: user.id}
       expect(user.role).to eql("standard")
     end

     it "redirects to the user path" do
       expect(response).to redirect_to user_path(user.id)
     end
   end

end
