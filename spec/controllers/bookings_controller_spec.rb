require 'spec_helper'

describe BookingsController do
  describe 'GET #index' do
    context "with a valid user signed in" do
      before :each do
        sign_in
      end

      it "populates an array of intakes" do
        intake1 = create(:intake)
        intake2 = create(:intake)
        get :index
        expect(assigns(:intakes)).to match_array([intake1, intake2])
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

      it "does not populate an array of intakes" do
        create(:intake)
        create(:intake)
        get :index
        expect(assigns(:intakes)).to be_nil
      end
      it "redirects to the sign in page" do
        get :index
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe 'GET #show' do
    before :each do
      @booking = create(:booking)
    end

    context "with a valid user signed in" do
      before :each do
        sign_in
      end

      it "assigns the requested booking to @booking" do
        get :show, id: @booking
        expect(assigns(:booking)).to eq @booking
      end

      it "retrieves the payment from the specified booking" do
        payment = create(:payment, booking: @booking)
        get :show, id: @booking
        expect(assigns(:payment)).to eq(payment)
      end

      it "renders the :show template" do
        get :show, id: @booking
        expect(response).to render_template :show
      end
    end

    context "with an invalid user signed in" do
      before :each do
        sign_in nil
      end

      it "does not assign the requested intake to @intake" do
        get :show, id: @booking
        expect(assigns(:booking)).to be_nil
      end
      it "redirects to the sign in page" do
        get :show, id: @booking
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe 'GET #new' do
    before :each do
      @course = create(:course)
    end

    it "assigns a new booking to @booking" do
      get :new, course_id: @course
      expect(assigns(:course)).to eq(@course)
      expect(assigns(:booking)).to be_a_new(Booking)
    end
    it "renders the :new template" do
      get :new, course_id: @course
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    let(:stripe_helper) { StripeMock.create_test_helper }
    before { StripeMock.start }
    after { StripeMock.stop }
    before :each do
      @intake = create(:intake)
      @course = @intake.course
    end

    context "with valid attributes" do
      it "assigns the required course to @course" do
        post :create, booking: attributes_for(:booking, intake_id: @intake)
        expect(assigns(:course)).to eq @course
      end
      it "assigns the required intake to @intake" do
        post :create, booking: attributes_for(:booking, intake_id: @intake)
        expect(assigns(:intake)).to eq @intake
      end
      it "saves the new booking in the database" do
        expect{
          post :create, booking: attributes_for(:booking, intake_id: @intake)
        }.to change(Booking, :count).by(1)
      end
      it "redirects to confirmation path" do
        post :create, booking: attributes_for(:booking, intake_id: @intake)
        expect(response).to redirect_to confirmation_path
      end
    end

    context "with invalid attributes" do
      it "assigns the required course to @course" do
        post :create, booking: attributes_for(:invalid_booking, intake_id: @intake)
        expect(assigns(:course)).to eq @course
      end
      it "assigns the required intake to @intake" do
        post :create, booking: attributes_for(:invalid_booking, intake_id: @intake)
        expect(assigns(:intake)).to eq @intake
      end
      it "does not save the new booking in the database" do
        expect{
          post :create, booking: attributes_for(:invalid_booking, intake_id: @intake)
        }.to_not change(Booking, :count)
      end
      it "re-renders the :new template" do
        post :create, booking: attributes_for(:invalid_booking, intake_id: @intake)
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #edit' do
    before :each do
      @intake = create(:intake)
    end

    context "with a valid user signed in" do
      before :each do
        sign_in
      end

      it "assigns the required intake to @intake" do
        booking = create(:booking, intake: @intake)
        get :edit, id: booking
        expect(assigns(:intake)).to eq @intake
      end
      it "assigns the requested booking to @booking" do
        booking = create(:booking, intake: @intake)
        get :edit, id: booking
        expect(assigns(:booking)).to eq booking
      end
      it "renders the :edit template" do
        booking = create(:booking, intake: @intake)
        get :edit, id: booking
        expect(response).to render_template :edit
      end
    end

    context "with an invalid user signed in" do
      before :each do
        sign_in nil
      end

      it "does not assign the requested booking to @booking" do
        booking = create(:booking, intake: @intake)
        get :edit, id: booking
        expect(assigns(:booking)).to be_nil
      end
      it "redirects to the sign in page" do
        booking = create(:booking, intake: @intake)
        get :edit, id: booking
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe 'PATCH #update' do
    before :each do
      @intake = create(:intake)
      @booking = create(:booking, people_attending: 3, total_cost: 0.00, intake: @intake)
    end

    context "with a valid user signed in" do
      before :each do
        sign_in
      end

      context "with valid attributes" do
        it "sets @intake to the bookings intake" do
          patch :update, id: @booking, booking: attributes_for(:booking)
          expect(assigns(:intake)).to eq(@intake)
        end
        it "locates the requested @booking" do
          patch :update, id: @booking, booking: attributes_for(:booking)
          expect(assigns(:booking)).to eq(@booking)
        end
        it "changes @booking's attributes" do
          patch :update, id: @booking, booking: attributes_for(:booking, people_attending: 4)
          @booking.reload
          expect(@booking.people_attending).to eq(4)
        end
        it "redirects to bookings#show" do
          patch :update, id: @booking, booking: attributes_for(:booking, people_attending: 4)
          expect(response).to redirect_to booking_path(@booking)
        end
      end

      context "with invalid attributes" do
        it "sets @intake to the bookings intake" do
          patch :update, id: @booking, booking: attributes_for(:booking)
          expect(assigns(:intake)).to eq(@intake)
        end
        it "does not change the @intake's attributes" do
          patch :update, id: @booking, booking: attributes_for(:booking, people_attending: 4, total_cost: nil)
          @booking.reload
          expect(@booking.people_attending).to_not eq(4)
          expect(@booking.total_cost).to eq(0.00)
        end
        it "re-renders the #edit template" do
          patch :update, id: @booking, booking: attributes_for(:invalid_booking)
          expect(response).to render_template :edit
        end
      end
    end

    context "with an invalid user signed in" do
      before :each do
        sign_in nil
      end

      it "does not update the booking" do
        patch :update, id: @booking, booking: attributes_for(:booking, people_attending: 4)
        @booking.reload
        expect(@booking.people_attending).to_not eq(4)
      end
      it "redirects to the sign in page" do
        patch :update, id: @booking, booking: attributes_for(:invalid_booking)
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @booking = create(:booking)
    end

    context "with valid user signed in" do
      before :each do
        sign_in
      end

      it "deletes the booking from the database" do
        expect{
          delete :destroy, id: @booking
        }.to change(Booking, :count).by(-1)
      end
      it "redirects to bookings#index" do
        delete :destroy, id: @booking
        expect(response).to redirect_to bookings_path
      end
    end

    context "with an invalid user signed in" do
      before :each do
        sign_in nil
      end

      it "does not delete the course from the database" do
        expect {
          delete :destroy, id: @booking
        }.to_not change(Booking, :count)
      end
      it "redirects to the sign in page" do
        delete :destroy, id: @booking
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

end
