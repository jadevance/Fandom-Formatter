class HomeController < ApplicationController
  def index
    @user = current_user
  end

  def create
    @file = params['input']

    if @file != nil
      if params['submit'] == "Mark it up!"
        render :markup
      else 
        render :markdown
      end 
    else
    render :index 
    end 
  end 

  def about

  end 

  def markup
    @file = markdown(@file)
  end

  def markdown
    @file = markdown(@file).html_safe
  end 

end
