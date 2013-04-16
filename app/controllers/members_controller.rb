class MembersController < ApplicationController
before_filter :authenticate_member!
  
  layout 'admin'


  def dashboard
    
  end
  
  def applications 
   
  end
  
  def settings
    
  end
  
  def profile
    @member = Member.find(current_member.id)
  end
  
  def update
    @member = Member.find(current_member.id)
    @member.fname = params[:fname]
    @member.lname = params[:lname]
    
    
    @member.save
    
  end
  
  def destroy
  end
end
