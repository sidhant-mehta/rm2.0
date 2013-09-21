class AboutUsController < ApplicationController
  def index
    redirect_to :action=>"how_it_works"
  end
  

  def how_it_works
  end

  def our_philosophy
  end

  def meet_the_team
  end
end
