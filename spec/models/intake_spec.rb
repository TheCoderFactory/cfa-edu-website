require 'spec_helper'

describe Intake do
  it "has a valid factory" do
    expect(FactoryGirl.build(:intake)).to be_valid
  end
  it "is valid with course, start, finish, location, days, status" do
    intake = Intake.new(
      course: FactoryGirl.build(:course),
      start: DateTime.now,
      finish: DateTime.now.tomorrow,
      location: "Coder Factory",
      days: "Sundays",
      status: "Active")
    expect(intake).to be_valid
  end
  it "should belong to a course" do
    t = Intake.reflect_on_association(:course)
    t.macro.should == :belongs_to
  end
  it "should have many bookings" do
    t = Intake.reflect_on_association(:bookings)
    t.macro.should == :has_many
  end
  it "is not valid without a course" do
    expect(Intake.new(course: nil)).to have(1).errors_on(:course)
  end
  it "is not valid without a start" do
    expect(Intake.new(start: nil)).to have(1).errors_on(:start)
  end
  it "is not valid without a finish" do
    expect(Intake.new(finish: nil)).to have(1).errors_on(:finish)
  end
  it "is not valid without a location"  do
    expect(Intake.new(location: nil)).to have(1).errors_on(:location)
  end
  it "is not valid without days" do
    expect(Intake.new(days: nil)).to have(1).errors_on(:days)
  end
  it "is not valid without status" do
    expect(Intake.new(status: nil)).to have(1).errors_on(:status)
  end
  it "should not have a status that is not 'Active', 'Cancelled', 'Full'" do
    expect(Intake.new(status: "Not Active")).to have(1).errors_on(:status)
  end
  it "should have no errors when status = Active" do
    expect(Intake.new(status: "Active")).to have(0).errors_on(:status)
  end
  it "should have no errors when status = Cancelled" do
    expect(Intake.new(status: "Cancelled")).to have(0).errors_on(:status)
  end
  it "should have no errors when status = Full" do
    expect(Intake.new(status: "Full")).to have(0).errors_on(:status)
  end
  it "should not have a finish date before a start date" do
    intake = Intake.new(
      course: FactoryGirl.build(:course),
      start: DateTime.now.tomorrow,
      finish: DateTime.now,
      location: "Coder Factory",
      days: "Sundays",
      status: "Active")
    expect(intake).to have(1).errors_on(:finish)
  end
end
