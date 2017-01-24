class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :get_footer_course_lists

  def after_sign_in_path_for(_resource_or_scope)
    admin_dashboard_path
  end
  def after_sign_out_path_for(_resource_or_scope)
    root_path
  end

  def get_footer_course_lists
    @short_courses = Course.active_courses.where(course_type: "Workshop").order(order: :asc)
    @footer_short_courses = Course.active_courses.where(course_type: "Workshop")
    @footer_corporate_courses = Course.active_courses.where(course_type: "Corporate")
    @footer_schools_courses = Course.active_courses.where(course_type: "Schools")
    @footer_kids_courses = Course.active_courses.where(course_type: "Kids")
  end
end
