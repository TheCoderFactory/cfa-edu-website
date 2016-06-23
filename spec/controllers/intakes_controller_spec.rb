require 'spec_helper'

describe IntakesController do
  describe 'GET #index' do
    context "with a valid user signed in" do
      before :each do
        sign_in
      end

      it "populates an array of courses" do
        course1 = create(:course, course_type: "Workshop")
        course2 = create(:course, course_type: "Corporate")
        get :index
        expect(assigns(:courses)).to match_array([course1, course2])
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

      it "does not populate an array of courses" do
        create(:course, course_type: "Workshop")
        create(:course, course_type: "Corporate")
        get :index
        expect(assigns(:courses)).to be_nil
      end
      it "redirects to the sign in page" do
        get :index
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe 'GET #show' do
    before :each do
      @intake = create(:intake)
    end

    context "with a valid user signed in" do
      before :each do
        sign_in
      end

      it "assigns the requested intake to @intake" do
        get :show, id: @intake
        expect(assigns(:intake)).to eq @intake
      end

      it "retrieves the array of bookings from the spcified intake" do
        booking1 = create(:booking, intake: @intake)
        booking2 = create(:booking, intake: @intake)
        booking3 = create(:booking, intake: @intake)
        get :show, id: @intake
        expect(assigns(:bookings)).to match_array([booking1, booking2, booking3])
      end

      it "renders the :show template" do
        get :show, id: @intake
        expect(response).to render_template :show
      end
    end

    context "with an invalid user signed in" do
      before :each do
        sign_in nil
      end

      it "does not assign the requested intake to @intake" do
        get :show, id: @intake
        expect(assigns(:intake)).to be_nil
      end
      it "redirects to the sign in page" do
        get :show, id: @intake
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe 'GET #new' do
    before :each do
      @course = create(:course)
    end

    context "with a valid user signed in" do
      before :each do
        sign_in
      end

      it "assigns a new intake to @intake" do
        get :new, course_id: @course
        expect(assigns(:course)).to eq(@course)
        expect(assigns(:intake)).to be_a_new(Intake)
      end
      it "renders the :new template" do
        get :new, course_id: @course
        expect(response).to render_template :new
      end
    end

    context "without a valid user signed in" do
      before :each do
        sign_in nil
      end

      it "does not create a new intake" do
        get :new, course_id: @course
        expect(assigns(:course)).to be_nil
        expect(assigns(:intake)).to be_nil
      end
      it "redirects to the sign in page" do
        get :new, course_id: @course
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe "POST #create" do
    before :each do
      @course = create(:course)
    end

    context "with a valid user signed in" do
      before :each do
        sign_in
      end

      context "with valid attributes" do
        it "assigns the required course to @course" do
          post :create, intake: attributes_for(:intake, course_id: @course)
          expect(assigns(:course)).to eq @course
        end
        it "saves the new intake in the database" do
          expect{
            post :create, intake: attributes_for(:intake, course_id: @course.id)
          }.to change(Intake, :count).by(1)
        end
        it "redirects to intakes#show" do
          post :create, intake: attributes_for(:intake, course_id: @course.id)
          expect(response).to redirect_to intake_path(assigns(:intake))
        end
      end

      context "with invalid attributes" do
        it "assigns the required course to @course" do
          post :create, intake: attributes_for(:invalid_intake, course_id: @course)
          expect(assigns(:course)).to eq @course
        end
        it "does not save the new intake in the database" do
          expect{
            post :create, intake: attributes_for(:invalid_intake, course_id: @course)
          }.to_not change(Intake, :count)
        end
        it "re-renders the :new template" do
          post :create, intake: attributes_for(:invalid_intake, course_id: @course)
          expect(response).to render_template :new
        end
      end
    end

    context "with an invalid user signed in" do
      before :each do
        sign_in nil
      end

      it "does not create a new intake" do
        expect{
          post :create, intake: attributes_for(:intake, course_id: @course)
        }.to_not change(Intake, :count)
      end
      it "redirects to the sign in page" do
        post :create, intake: attributes_for(:intake, course_id: @course)
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe 'GET #edit' do
    before :each do
      @course = create(:course)
    end

    context "with a valid user signed in" do
      before :each do
        sign_in
      end

      it "assigns the required course to @course" do
        post :create, intake: attributes_for(:intake, course_id: @course)
        expect(assigns(:course)).to eq @course
      end
      it "assigns the requested intake to @intake" do
        intake = create(:intake, course: @course)
        get :edit, id: intake
        expect(assigns(:intake)).to eq intake
      end
      it "renders the :edit template" do
        intake = create(:intake, course: @course)
        get :edit, id: intake
        expect(response).to render_template :edit
      end
    end

    context "with an invalid user signed in" do
      before :each do
        sign_in nil
      end

      it "does not assign the requested intake to @intake" do
        intake = create(:intake, course: @course)
        get :edit, id: intake
        expect(assigns(:intake)).to be_nil
      end
      it "redirects to the sign in page" do
        intake = create(:intake, course: @course)
        get :edit, id: intake
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe 'PATCH #update' do
    before :each do
      @course = create(:course)
      @intake = create(:intake, location: 'Coder Factory Headq', class_size: 20, course: @course)
    end

    context "with a valid user signed in" do
      before :each do
        sign_in
      end

      context "with valid attributes" do
        it "sets @course to the intakes course" do
          patch :update, id: @intake, intake: attributes_for(:intake)
          expect(assigns(:course)).to eq(@course)
        end
        it "locates the requested @intake" do
          patch :update, id: @intake, intake: attributes_for(:intake)
          expect(assigns(:intake)).to eq(@intake)
        end
        it "changes @course's attributes" do
          patch :update, id: @intake, intake: attributes_for(:intake, location: "AIT Headq")
          @intake.reload
          expect(@intake.location).to eq("AIT Headq")
        end
        it "redirects to intakes#show" do
          patch :update, id: @intake, intake: attributes_for(:intake, location: "AIT Headq")
          expect(response).to redirect_to intake_path(@intake)
        end
      end

      context "with invalid attributes" do
        it "sets @course to the intakes course" do
          patch :update, id: @intake, intake: attributes_for(:intake)
          expect(assigns(:course)).to eq(@course)
        end
        it "does not change the @intake's attributes" do
          patch :update, id: @intake, intake: attributes_for(:intake, location: "AIT Headq", class_size: nil)
          @intake.reload
          expect(@intake.location).to_not eq("AIT Headq")
          expect(@intake.class_size).to eq(20)
        end
        it "re-renders the #edit template" do
          patch :update, id: @intake, intake: attributes_for(:invalid_intake)
          expect(response).to render_template :edit
        end
      end
    end

    context "with an invalid user signed in" do
      before :each do
        sign_in nil
      end

      it "does not update the intake" do
        patch :update, id: @intake, intake: attributes_for(:intake, location: "AIT Headq")
        @intake.reload
        expect(@intake.location).to_not eq("AIT Headq")
      end
      it "redirects to the sign in page" do
        patch :update, id: @intake, intake: attributes_for(:invalid_intake)
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @intake = create(:intake)
    end

    context "with valid user signed in" do
      before :each do
        sign_in
      end

      it "deletes the intake from the database" do
        expect{
          delete :destroy, id: @intake
        }.to change(Intake, :count).by(-1)
      end
      it "redirects to intakes#index" do
        delete :destroy, id: @intake
        expect(response).to redirect_to intakes_path
      end
    end

    context "with an invalid user signed in" do
      before :each do
        sign_in nil
      end

      it "does not delete the course from the database" do
        expect {
          delete :destroy, id: @intake
        }.to_not change(Intake, :count)
      end
      it "redirects to the sign in page" do
        delete :destroy, id: @intake
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end
end
