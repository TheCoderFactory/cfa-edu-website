require 'spec_helper'

describe Course do
  it "has a valid factory" do
    expect(FactoryGirl.build(:course)).to be_valid
  end
  it "has many intakes" do
    t = Course.reflect_on_association(:intakes)
    t.macro.should == :has_many
  end
  it "is valid with course_type, name, description, tagline, price" do
    course = Course.new(
      course_type: "Part Time",
      name: "Coding Kickstarter",
      description: "Learn coding for free.",
      tagline: "Learn coding is fun.",
      price: 0.00)
    expect(course).to be_valid
  end
  it "is not valid without course_type" do
    expect(Course.new(course_type: nil)).to have(1).errors_on(:course_type)
  end
  it "is not valid without name" do
    expect(Course.new(name: nil)).to have(1).errors_on(:name)
  end
  it "is not valid without description" do
    expect(Course.new(description: nil)).to have(1).errors_on(:description)
  end
  it "is not valid without tagline" do
    expect(Course.new(tagline: nil)).to have(1).errors_on(:tagline)
  end
  it "is not valid without price" do
    expect(Course.new(price: nil)).to have(1).errors_on(:price)
  end
  it "should not have a negative price" do
    expect(Course.new(price: -1.00)).to have(1).errors_on(:price)
  end
end
