class SitemapController < ApplicationController
  layout :false
  def index
    @last_updated = Intake.last.created_at
    @short_courses = Course.where(course_type: "Workshop")
    @corporate_courses = Course.where(course_type: "Corporate")
    @schools_courses = Course.where(course_type: "Schools")
    @kids_courses = Course.where(course_type: "Kids")
    @posts = Post.all
    @static_urls = [
      root_url,
      fast_track_url,
      fast_track_apply_url,
      fast_track_women_in_tech_scholarship_url,
      fast_track_women_in_tech_scholarship_apply_url,
      short_courses_url,
      corporate_url,
      kids_coding_url,
      blog_url,
      about_coder_factory_academy_url,
      career_outcomes_url,
      contact_url,
      faq_url,
      meet_your_instructors_url,
      partners_url,
      privacy_url
    ]
    headers['Content-Type'] = 'application/xml'
    respond_to do |format|
      format.xml
    end
  end
end
