class FastTrackController < ApplicationController
  def index
  end

  def ft_syd
    @partners = Partner.active.ordered
  end

  def ft_mel
    @partners = Partner.active.ordered
  end

  def apply
  end

  def scholarships
  end

  def wit_scholarship_info
  end

  def wit_scholarship_apply
  end
end
