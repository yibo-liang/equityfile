require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe LoginsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Login. As you add validations to Login, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # LoginsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all logins as @logins" do
      login = Login.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:logins)).to eq([login])
    end
  end

  describe "GET #show" do
    it "assigns the requested login as @login" do
      login = Login.create! valid_attributes
      get :show, {:id => login.to_param}, valid_session
      expect(assigns(:login)).to eq(login)
    end
  end

  describe "GET #new" do
    it "assigns a new login as @login" do
      get :new, {}, valid_session
      expect(assigns(:login)).to be_a_new(Login)
    end
  end

  describe "GET #edit" do
    it "assigns the requested login as @login" do
      login = Login.create! valid_attributes
      get :edit, {:id => login.to_param}, valid_session
      expect(assigns(:login)).to eq(login)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Login" do
        expect {
          post :create, {:login => valid_attributes}, valid_session
        }.to change(Login, :count).by(1)
      end

      it "assigns a newly created login as @login" do
        post :create, {:login => valid_attributes}, valid_session
        expect(assigns(:login)).to be_a(Login)
        expect(assigns(:login)).to be_persisted
      end

      it "redirects to the created login" do
        post :create, {:login => valid_attributes}, valid_session
        expect(response).to redirect_to(Login.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved login as @login" do
        post :create, {:login => invalid_attributes}, valid_session
        expect(assigns(:login)).to be_a_new(Login)
      end

      it "re-renders the 'new' template" do
        post :create, {:login => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested login" do
        login = Login.create! valid_attributes
        put :update, {:id => login.to_param, :login => new_attributes}, valid_session
        login.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested login as @login" do
        login = Login.create! valid_attributes
        put :update, {:id => login.to_param, :login => valid_attributes}, valid_session
        expect(assigns(:login)).to eq(login)
      end

      it "redirects to the login" do
        login = Login.create! valid_attributes
        put :update, {:id => login.to_param, :login => valid_attributes}, valid_session
        expect(response).to redirect_to(login)
      end
    end

    context "with invalid params" do
      it "assigns the login as @login" do
        login = Login.create! valid_attributes
        put :update, {:id => login.to_param, :login => invalid_attributes}, valid_session
        expect(assigns(:login)).to eq(login)
      end

      it "re-renders the 'edit' template" do
        login = Login.create! valid_attributes
        put :update, {:id => login.to_param, :login => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested login" do
      login = Login.create! valid_attributes
      expect {
        delete :destroy, {:id => login.to_param}, valid_session
      }.to change(Login, :count).by(-1)
    end

    it "redirects to the logins list" do
      login = Login.create! valid_attributes
      delete :destroy, {:id => login.to_param}, valid_session
      expect(response).to redirect_to(logins_url)
    end
  end

end
