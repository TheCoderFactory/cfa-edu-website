require 'spec_helper'

describe PromoCodesController do
  describe 'GET #index' do
    context "with a valid user signed in" do
      before :each do
        sign_in
      end

      it "populates an array of all promo codes" do
        code1 = create(:promo_code, code: "Code1")
        code2 = create(:promo_code, code: "Code2")
        get :index
        expect(assigns(:promo_codes)).to match_array([code1, code2])
      end
      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    context "without a valid user signed in" do
      before :each do
        sign_in nil
      end

      it "does not populate an array of all promo codes" do
        create(:promo_code, code: "Code1")
        create(:promo_code, code: "Code2")
        get :index
        expect(assigns(:promo_codes)).to be_nil
      end
      it "redirects to the sign in page" do
        get :index
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe 'GET #new' do
    context "with a valid user signed in" do
      before :each do
        sign_in
      end

      it "assigns a new promo code to @promo_code" do
        get :new
        expect(assigns(:promo_code)).to be_a_new(PromoCode)
      end
      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    context "without a valid user signed in" do
      before :each do
        sign_in nil
      end

      it "does not create a new promo code" do
        get :new
        expect(assigns(:promo_code)).to be_nil
      end
      it "redirects to the sign in page" do
        get :new
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe "POST #create" do
    context "with a valid user signed in" do
      before :each do
        sign_in
      end

      context "with valid attributes" do
        it "saves the new promo code in the database" do
          expect{
            post :create, promo_code: attributes_for(:promo_code)
          }.to change(PromoCode, :count).by(1)
        end
        it "redirects to promo_codes#index" do
          post :create, promo_code: attributes_for(:promo_code)
          expect(response).to redirect_to promo_codes_path
        end
      end

      context "with invalid attributes" do
        it "does not save the new promo_code in the database" do
          sign_in
          expect{
            post :create, promo_code: attributes_for(:invalid_promo_code)
          }.to_not change(PromoCode, :count)
        end
        it "re-renders the :new template" do
          sign_in
          post :create, promo_code: attributes_for(:invalid_promo_code)
          expect(response).to render_template :new
        end
      end
    end

    context "with an invalid user signed in" do
      before :each do
        sign_in nil
      end

      it "does not create a new promo code" do
        expect{
          post :create, promo_code: attributes_for(:promo_code)
        }.to_not change(PromoCode, :count)
      end
      it "redirects to the sign in page" do
        post :create, promo_code: attributes_for(:promo_code)
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe 'GET #edit' do
    context "with a valid user signed in" do
      before :each do
        sign_in
      end

      it "assigns the requested promo code to @promo_code" do
        promo_code = create(:promo_code)
        get :edit, id: promo_code
        expect(assigns(:promo_code)).to eq promo_code
      end
      it "renders the :edit template" do
        promo_code = create(:promo_code)
        get :edit, id: promo_code
        expect(response).to render_template :edit
      end
    end

    context "with an invalid user signed in" do
      before :each do
        sign_in nil
      end

      it "does not assign the requested promo code to @promo_code" do
        promo_code = create(:promo_code)
        get :edit, id: promo_code
        expect(assigns(:promo_code)).to be_nil
      end
      it "redirects to the sign in page" do
        promo_code = create(:promo_code)
        get :edit, id: promo_code
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe 'PATCH #update' do
    before :each do
      @promo_code = create(:promo_code, code: 'First', percent: 10)
    end

    context "with a valid user signed in" do
      before :each do
        sign_in
      end

      context "with valid attributes" do
        it "locates the requested @promo_code" do
          patch :update, id: @promo_code, promo_code: attributes_for(:promo_code)
          expect(assigns(:promo_code)).to eq(@promo_code)
        end
        it "changes @promo_code's attributes" do
          patch :update, id: @promo_code, promo_code: attributes_for(:promo_code, code: "Second")
          @promo_code.reload
          expect(@promo_code.code).to eq("Second")
        end
        it "redirects to promo_code#index" do
          patch :update, id: @promo_code, promo_code: attributes_for(:promo_code, code: "Second")
          expect(response).to redirect_to promo_codes_path
        end
      end

      context "with invalid attributes" do
        it "does not change the @promo_codes attributes" do
          patch :update, id: @promo_code, promo_code: attributes_for(:promo_code, code: "Second", percent: nil)
          @promo_code.reload
          expect(@promo_code.code).to_not eq("Second")
          expect(@promo_code.percent).to eq(10)
        end
        it "re-renders the #edit template" do
          patch :update, id: @promo_code, promo_code: attributes_for(:invalid_promo_code)
          expect(response).to render_template :edit
        end
      end
    end

    context "with an invalid user signed in" do
      before :each do
        sign_in nil
      end

      it "does not update the promo code" do
        patch :update, id: @promo_code, promo_code: attributes_for(:promo_code, code: "Second", percent: nil)
        @promo_code.reload
        expect(@promo_code.code).to_not eq("Second")
        expect(@promo_code.percent).to eq(10)
      end
      it "redirects to the sign in page" do
        patch :update, id: @promo_code, promo_code: attributes_for(:invalid_promo_code)
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @promo_code = create(:promo_code)
    end

    context "with valid user signed in" do
      before :each do
        sign_in
      end

      it "deletes the promo_code from the database" do
        expect{
          delete :destroy, id: @promo_code
        }.to change(PromoCode, :count).by(-1)
      end
      it "redirects to promo_codes#index" do
        delete :destroy, id: @promo_code
        expect(response).to redirect_to promo_codes_path
      end
    end

    context "with an invalid user signed in" do
      before :each do
        sign_in nil
      end

      it "does not delete the promo code from the database" do
        expect {
          delete :destroy, id: @promo_code
        }.to_not change(PromoCode, :count)
      end
      it "redirects to the sign in page" do
        delete :destroy, id: @promo_code
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end
end
