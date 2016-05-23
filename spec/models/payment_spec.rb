require 'spec_helper'

describe Payment do
  it "has a valid factory" do
    expect(FactoryGirl.build(:payment)).to be_valid
  end
  it "is valid with booking, amount" do
    payment = Payment.new(
      booking: FactoryGirl.build(:booking),
      amount: 0.00)
    expect(payment).to be_valid
  end
  it "should belong to an intake" do
    t = Payment.reflect_on_association(:booking)
    t.macro.should == :belongs_to
  end
  it "is invalid without a booking" do
    expect(Payment.new(booking: nil)).to have(1).errors_on(:booking)
  end
  it "is invalid without an amount" do
    expect(Payment.new(amount: nil)).to have(1).errors_on(:amount)
  end
  it "is invalid if the amount is not equal to the booking amount" do
    payment = Payment.new(
      booking: FactoryGirl.build(:booking),
      amount: 1.00)
    expect(payment).to have(1).errors_on(:amount)
  end
  it "should not have a negative amount" do
    expect(Payment.new(amount: nil)).to have(1).errors_on(:amount)
  end
end
