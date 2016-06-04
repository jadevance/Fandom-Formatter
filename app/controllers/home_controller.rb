class HomeController < ApplicationController
  def index
    @user = current_user
  end

  def create
    @file = params['input']
    render :index 
  end 

  def about

  end 

end
