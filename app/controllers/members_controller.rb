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
    @m = Member.find(current_member.id)
    #@m =  Member.find(params[:member => ""])
    @m.fname = params[:fname]
    @m.lname = params[:lname]
    
    
    if @m.save 
      redirect_to member_path, :notice => 'Your profile has been updated successfully.'
    else
      render "profile"
    end
    
  end
  
  def destroy
  end
end
