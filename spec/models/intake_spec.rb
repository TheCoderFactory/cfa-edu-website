require 'spec_helper'

describe Intake do
  it "has a valid factory" do
    expect(FactoryGirl.build(:intake)).to be_valid
  end
  it "is valid with course, start, finish, location, class_size" do
    intake = Intake.new(
      course: FactoryGirl.build(:course),
      start: DateTime.now,
      finish: DateTime.now.tomorrow,
      location: "Coder Factory",
      class_size: 20)
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
  it "is not valid without a class_size" do
    expect(Intake.new(class_size: nil)).to have(1).errors_on(:class_size)
  end
  it "should not have a finish date before a start date" do
    intake = Intake.new(
      course: FactoryGirl.build(:course),
      start: DateTime.now.tomorrow,
      finish: DateTime.now,
      location: "Coder Factory",
      class_size: 20)
    expect(intake).to have(1).errors_on(:finish)
  end
end
