class PagesController < ApplicationController
  def about
  end

  # def alumni
  # end

  def career_outcomes
  end

  def confirmation
    @type = params[:type]
    @type ||= "booking"
  end

  def contact
  end

  def curriculum
  end

  def faq
  end

  def information_toolkit
  end

  def instructors
  end

  def partners
  end

  def privacy
  end

  def video_archive
  end
end
