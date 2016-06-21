require 'spec_helper'

describe Booking do
  it "has a valid factory" do
    expect(FactoryGirl.build(:booking)).to be_valid
  end
  it "is valid with intake, people_attending, total_cost, fisrtname, lastname, email, phone, age, city, country" do
    booking = Booking.new(
      intake: FactoryGirl.build(:intake),
      people_attending: 2,
      total_cost: 0.00,
      firstname: "Pete",
      lastname: "Argent",
      email: "test@coderfactory.com",
      phone: "1111111111",
      age: "33",
      city: "Sydney",
      country: "Australia")
    expect(booking).to be_valid
  end
  it "should belong to an intake" do
    t = Booking.reflect_on_association(:intake)
    t.macro.should == :belongs_to
  end
  it "should belong to an promo_code" do
    t = Booking.reflect_on_association(:promo_code)
    t.macro.should == :belongs_to
  end
  it "is not valid if an intake is full" do
    intake = FactoryGirl.build(:intake)
    10.times do
      intake.bookings << FactoryGirl.build(:booking)
    end
    booking = Booking.new(
      intake: intake,
      people_attending: 2,
      total_cost: 0.00)
    expect(booking).to have(1).errors_on(:intake)
  end
  it "should have one payment" do
    t = Booking.reflect_on_association(:payment)
    t.macro.should == :has_one
  end
  it "is not valid without an intake" do
    expect(Booking.new(intake: nil)).to have(1).errors_on(:intake)
  end
  it "is not valid without people_attending" do
    expect(Booking.new(people_attending: nil)).to have(1).errors_on(:people_attending)
  end
  it "is not valid without a total_cost" do
    expect(Booking.new(total_cost: nil)).to have(1).errors_on(:total_cost)
  end
  it "should not have a total_cost different to the course.price*people_attending" do
    booking1 = Booking.new(
      intake: FactoryGirl.build(:intake),
      people_attending: 2,
      total_cost: 2.00)
    expect(booking1).to have(1).errors_on(:total_cost)
    booking2 = Booking.new(
      intake: FactoryGirl.build(:intake),
      people_attending: 2,
      total_cost: -2.00)
    expect(booking2).to have(2).errors_on(:total_cost)
  end
  it "should not have a negative total_cost" do
    expect(Booking.new(total_cost: -2.00)).to have(1).errors_on(:total_cost)
  end
end
