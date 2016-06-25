require 'spec_helper'

describe CoursesController do
  describe 'GET #index' do
    context "with a valid user signed in" do
      before :each do
        sign_in
      end

      # populates an arroy of course based on certain params
      it "populates an array of all courses if no course_type params provided" do
        course1 = create(:course, course_type: "Workshop")
        course2 = create(:course, course_type: "Corporate")
        course3 = create(:course, course_type: "Schools")
        get :index
        expect(assigns(:courses)).to match_array([course1, course2, course3])
      end
      it "populates an array of workshop only courses course_type=workshop param provided" do
        course = create(:course, course_type: "Workshop")
        create(:course, course_type: "Corporate")
        create(:course, course_type: "Schools")
        get :index, course_type: "Workshop"
        expect(assigns(:courses)).to match_array([course])
      end
      it "populates an array of corporate only courses course_type=corporate param provided" do
        create(:course, course_type: "Workshop")
        course = create(:course, course_type: "Corporate")
        create(:course, course_type: "Schools")
        get :index, course_type: "Corporate"
        expect(assigns(:courses)).to match_array([course])
      end
      it "populates an array of schools only courses course_type=schools param provided" do
        create(:course, course_type: "Workshop")
        create(:course, course_type: "Corporate")
        course = create(:course, course_type: "Schools")
        get :index, course_type: "Schools"
        expect(assigns(:courses)).to match_array([course])
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

      it "does not populate any arrays of courses" do
        create(:course, course_type: "Workshop")
        create(:course, course_type: "Corporate")
        create(:course, course_type: "Schools")
        get :index
        expect(assigns(:workshop_courses)).to be_nil
        expect(assigns(:corporate_courses)).to be_nil
        expect(assigns(:schools_courses)).to be_nil
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

      it "assigns a new course to @course" do
        get :new
        expect(assigns(:course)).to be_a_new(Course)
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

      it "does not create a new course" do
        get :new
        expect(assigns(:course)).to be_nil
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
        it "saves the new course in the database" do
          expect{
            post :create, course: attributes_for(:course)
          }.to change(Course, :count).by(1)
        end
        it "redirects to courses#show" do
          post :create, course: attributes_for(:course)
          expect(response).to redirect_to course_path(assigns(:course))
        end
      end

      context "with invalid attributes" do
        it "does not save the new course in the database" do
          expect{
            post :create, course: attributes_for(:invalid_course)
          }.to_not change(Course, :count)
        end
        it "re-renders the :new template" do
          post :create, course: attributes_for(:invalid_course)
          expect(response).to render_template :new
        end
      end
    end

    context "with an invalid user signed in" do
      before :each do
        sign_in nil
      end

      it "does not create a new course" do
        expect{
          post :create, course: attributes_for(:course)
        }.to_not change(Course, :count)
      end
      it "redirects to the sign in page" do
        post :create, course: attributes_for(:course)
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe 'GET #edit' do
    context "with a valid user signed in" do
      before :each do
        sign_in
      end

      it "assigns the requested course to @course" do
        course = create(:course)
        get :edit, id: course
        expect(assigns(:course)).to eq course
      end
      it "renders the :edit template" do
        course = create(:course)
        get :edit, id: course
        expect(response).to render_template :edit
      end
    end

    context "with an invalid user signed in" do
      before :each do
        sign_in nil
      end

      it "does not assign the requested course to @course" do
        course = create(:course)
        get :edit, id: course
        expect(assigns(:course)).to be_nil
      end
      it "redirects to the sign in page" do
        course = create(:course)
        get :edit, id: course
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe 'PATCH #update' do
    before :each do
      @course = create(:course, course_type: 'Workshop', name: "Kickstarter")
    end

    context "with a valid user signed in" do
      before :each do
        sign_in
      end

      context "with valid attributes" do
        it "locates the requested @course" do
          patch :update, id: @course, course: attributes_for(:course)
          expect(assigns(:course)).to eq(@course)
        end
        it "changes @course's attributes" do
          patch :update, id: @course, course: attributes_for(:course, course_type: "Corporate")
          @course.reload
          expect(@course.course_type).to eq("Corporate")
        end
        it "redirects to course#show" do
          patch :update, id: @course, course: attributes_for(:course, course_type: "Corporate")
          expect(response).to redirect_to course_path(@course)
        end
      end

      context "with invalid attributes" do
        it "does not change the @course's attributes" do
          patch :update, id: @course, course: attributes_for(:course, course_type: "Corporate", name: nil)
          @course.reload
          expect(@course.course_type).to_not eq("Corporate")
          expect(@course.name).to eq("Kickstarter")
        end
        it "re-renders the #edit template" do
          patch :update, id: @course, course: attributes_for(:invalid_course)
          expect(response).to render_template :edit
        end
      end
    end

    context "with an invalid user signed in" do
      before :each do
        sign_in nil
      end

      it "does not update the course" do
        patch :update, id: @course, course: attributes_for(:course, course_type: "Corporate")
        @course.reload
        expect(@course.course_type).to_not eq("Corporate")
      end
      it "redirects to the sign in page" do
        patch :update, id: @course, course: attributes_for(:invalid_course)
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @course = create(:course)
    end

    context "with valid user signed in" do
      before :each do
        sign_in
      end

      it "deletes the course from the database" do
        expect{
          delete :destroy, id: @course
        }.to change(Course, :count).by(-1)
      end
      it "redirects to courses#index" do
        delete :destroy, id: @course
        expect(response).to redirect_to courses_path
      end
    end

    context "with an invalid user signed in" do
      before :each do
        sign_in nil
      end

      it "does not delete the course from the database" do
        expect {
          delete :destroy, id: @course
        }.to_not change(Course, :count)
      end
      it "redirects to the sign in page" do
        delete :destroy, id: @course
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end
end
