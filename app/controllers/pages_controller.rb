class PagesController < ApplicationController
  def about
  end

  # def alumni
  # end

  def career_outcomes
  end

  def confirmation
    course = Course.friendly.find(params[:course_id]) if params[:course_id]
    @type = course.name.downcase + " booking" if course
    @type = params[:type] if params[:type]
    @type ||= "booking"
  end

  def contact
  end

  def syd_curriculum
  end

  def mel_curriculum
  end

  def faq
  end

  def information_toolkit
  end

  def instructors
  end

  def partners
  end

  def payment_options
  end

  def privacy
  end

  def cfa_international
  end

  def terms
  end
end
