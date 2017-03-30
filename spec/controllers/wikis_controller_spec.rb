require 'rails_helper'
require 'faker'

RSpec.describe WikisController, type: :controller do

  before :example do
   @user = create :user
   sign_in @user
   @wiki = create :wiki
  end

  context
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end


  describe "GET new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new
        expect(response).to render_template :new
      end

      it "instantiates @wiki" do
        get :new
        expect(assigns(:wiki)).not_to be_nil
      end
    end

    describe "POST create" do
      it "increases the number of Wiki by 1" do
        expect{post :create, wiki: {title: Faker::Book.title, body: Faker::Book.author, private: false, user: @user}}.to change(Wiki,:count).by(1)
      end

      it "assigns the new wiki to @wiki" do
        post :create, wiki: {title: Faker::Book.title, body: Faker::Book.author, private: false, user: @user}
        expect(assigns(:wiki)).to eq Wiki.last
      end

      it "redirects to the new wiki" do
        post :create, wiki: {title: Faker::Book.title, body: Faker::Book.author, private: false, user: @user}
        expect(response).to redirect_to Wiki.last
      end
    end

  describe "GET edit" do
      it "returns http success" do
        get :edit, {id: @wiki.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, {id: @wiki.id}
        expect(response).to render_template :edit
      end

      it "assigns wiki to be updated to @wiki" do
        get :edit, {id: @wiki.id}

        wiki_instance = assigns(:wiki)

        expect(wiki_instance.id).to eq @wiki.id
        expect(wiki_instance.title).to eq @wiki.title
        expect(wiki_instance.body).to eq @wiki.body
        expect(wiki_instance.private).to eq @wiki.private
        expect(wiki_instance.user).to eq @wiki.user
      end
  end

  describe "PUT update" do
     it "updates wiki with expected attributes" do
       new_title = Faker::Book.title
       new_body = Faker::Book.author
       new_private = false
       new_user = create :user

       put :update, id: @wiki.id, wiki: {title: new_title, body: new_body, private: new_private, user: new_user}

       updated_wiki = assigns(:wiki)
       expect(updated_wiki.id).to eq @wiki.id
       expect(updated_wiki.title).to eq new_title
       expect(updated_wiki.body).to eq new_body
     end

     it "redirects to the updated wiki" do
       new_title = Faker::Book.title
       new_body = Faker::Book.author
       new_private = false
       new_user = create :user

       put :update, id: @wiki.id, wiki: {title: new_title, body: new_body, private: new_private, user: new_user}
       expect(response).to redirect_to @wiki
     end
   end

   describe "DELETE destroy" do
      it "deletes the wiki" do
        delete :destroy, {id: @wiki.id}
        count = Wiki.where({id: @wiki.id}).size
        expect(count).to eq 0
      end

      it "redirects to wikis index" do
        delete :destroy, {id: @wiki.id}
        expect(response).to redirect_to wikis_path
      end
    end

end
