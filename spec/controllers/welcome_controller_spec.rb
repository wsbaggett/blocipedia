require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe "GET index" do
    it "returns http redirect" do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
   end
end
