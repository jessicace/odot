require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:valid_attributes) { { 
    "first_name" => "Jessica",
    "last_name" => "Edwards",
    "email" => "jessica@eml.cc",
    "password" => "jessica",
    "password_confirmation" => "jessica"
                           } }

  let(:invalid_attributes) { { 
    "first_name" => "Jessica",
    "last_name" => "Edwards",
    "email" => "jessica",
    "password" => "jessica",
    "password_confirmation" => "jessic"
                           } }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all users as @users" do
      user = User.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:users)).to eq([user])
    end
  end

  describe "GET #show" do
    it "assigns the requested user as @user" do
      user = User.create! valid_attributes
      get :show, { id: user.to_param }, valid_session
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "GET #new" do
    it "assigns a new user as @user" do
      get :new, {}, valid_session
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "GET #edit" do
    it "assigns the requested user as @user" do
      user = User.create! valid_attributes
      get :edit, { id: user.to_param }, valid_session
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, { user: valid_attributes }, valid_session
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, { user: valid_attributes }, valid_session
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it "redirects to the todo lists path" do
        post :create, { user: valid_attributes }, valid_session
        expect(response).to redirect_to(todo_lists_path)
      end

      it "sets the flash success message" do
        post :create, { user: valid_attributes }, valid_session
        expect(flash[:success]).to eq("User was successfully created.")
      end

      it "sets the session user_id to the created user" do
        post :create, { user: valid_attributes }, valid_session
        expect(session[:user_id]).to eq(User.find_by(email: valid_attributes["email"]).id)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        allow_any_instance_of(User).to receive(:save).and_return(false)
        post :create, { user: invalid_attributes }, valid_session
        expect(assigns(:user)).to be_a_new(User)
      end

      it "re-renders the 'new' template" do
        allow_any_instance_of(User).to receive(:save).and_return(false)
        post :create, { user: invalid_attributes }, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { {
                              "first_name" => "Jess",
                              "last_name" => "Edwards",
                              "email" => "jessica@email.cc",
                              "password" => "jessica",
                              "password_confirmation" => "jessica"
                             } }

      it "updates the requested user" do
        user = User.create!(valid_attributes)
        allow_any_instance_of(User).to receive(:update).with(new_attributes)
        put :update, { id: user.to_param, user: new_attributes}, valid_session
      end

      it "assigns the requested user as @user" do
        user = User.create!(valid_attributes)
        put :update, { id: user.to_param, user: valid_attributes}, valid_session
        expect(assigns(:user)).to eq(user)
      end

      it "redirects to the user" do
        user = User.create!(valid_attributes)
        put :update, { id: user.to_param, user: valid_attributes}, valid_session
        expect(response).to redirect_to(user)
      end
    end

    context "with invalid params" do
      it "assigns the user as @user" do
        user = User.create!(valid_attributes)
        put :update, { id: user.to_param, user: invalid_attributes}, valid_session
        expect(assigns(:user)).to eq(user)
      end

      it "re-renders the 'edit' template" do
        user = User.create!(valid_attributes)
        allow_any_instance_of(User).to receive(:save).and_return(false)
        put :update, { id: user.to_param, user: invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      user = User.create!(valid_attributes)
      expect { delete :destroy, { id: user.to_param}, valid_session
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      user = User.create!(valid_attributes)
      delete :destroy, { id: user.to_param}, valid_session
      expect(response).to redirect_to(users_url)
    end
  end

end
