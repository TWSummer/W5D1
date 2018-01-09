require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#new" do
    it "renders the 'new' template" do
      get :new
      expect(response).to render_template("new")
    end
  end
  describe "#create" do
    context "when credentials are valid" do
      before(:each) do
        post :create, params: { user: {username: "Theo", password: "password" }}
      end

      it "logs in the user" do
        expect(session[:session_token]).to be_present
      end
      it "redirects to user's show page" do
        expect(response).to redirect_to user_url(User.last)
      end
    end

    context "when credentials are invalid" do
      before(:each) do
        post :create, params: { user: {username: nil, password: "password" }}
      end

      it "renders the new template" do
        expect(response).to render_template("new")
      end
      it "flashes errors" do
        expect(flash[:errors]).to eq(["Username can't be blank"])
      end
    end
  end
  describe "#show" do
    user = FactoryBot.create(:user)
    it "renders the user's show page" do
      get :show, params: { id: user.id }
    end
  end

end
