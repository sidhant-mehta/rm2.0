class MembersController < ApplicationController
before_filter :authenticate_member!
  
  layout 'admin'


  def dashboard
    
  end

end
