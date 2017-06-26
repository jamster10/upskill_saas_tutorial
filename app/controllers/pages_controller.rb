class PagesController < ApplicationController
  #get request for / which is home page
  
  def home
  @basic_plan = Plan.find(1)
  @pro_plan = Plan.find(2)
  end
  
  #get request to about page /about
  
  def about
  end
end
