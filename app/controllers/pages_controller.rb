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
    @partners = Partner.active.ordered
  end

  def payment_options
  end

  def privacy
  end

  def cfa_international
  end

end
