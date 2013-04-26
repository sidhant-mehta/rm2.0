class AboutUsController < ApplicationController
  def index
    redirect_to :action=>"what_we_do"
  end
  
  def what_we_do
  end

  def how_it_works
  end

  def our_philosophy
  end

  def meet_the_team
  end
end
