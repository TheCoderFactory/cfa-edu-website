require 'spec_helper'

describe PromoCode do
  it "has a valid factory" do
    expect(FactoryGirl.build(:promo_code)).to be_valid
  end
  it "is valid with code, percent, note" do
    promo_code = PromoCode.new(
      code: "test_code",
      percent: 10,
      note: "Test code")
    expect(promo_code).to be_valid
  end
  it "should have many bookings" do
    t = PromoCode.reflect_on_association(:bookings)
    t.macro.should == :has_many
  end
  it "is invalid without code" do
    expect(PromoCode.new(code: nil)).to have(1).errors_on(:code)
  end
  it "is invalid without percent" do
    expect(PromoCode.new(percent: nil)).to have(1).errors_on(:percent)
  end
  it "is invalid without note" do
    expect(PromoCode.new(note: nil)).to have(1).errors_on(:note)
  end
  it "is invalid if the code is not unique" do
    PromoCode.create(
      code: "test_code",
      percent: 10,
      note: "Test code")
    promo_code2 = PromoCode.new(
      code: "test_code",
      percent: 10,
      note: "Test code")
    expect(promo_code2).to have(1).errors_on(:code)
  end
end
