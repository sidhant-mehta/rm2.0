class PagesController < ApplicationController
  def our_policy
  end

  def terms_of_use
  end

  def terms_and_conditions
  end

  def contact_us
  end
  
  def send_email
    @user = {
      "name" => params[:name],
      "email" => params[:email],
      "message" => params[:message]
    }
      begin
          PagesMailer.contact_us_initial_reply(@user).deliver
          PagesMailer.contact_us_forward_to_info(@user).deliver
      rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
            flash[:alert] = "Unfortunately there was a problem in sending your email. Please check your email address and try again."
      end
      
      respond_to  do |format|
          if flash[:alert].blank? 
            flash[:notice] = 'Your message was sent successfully.'
          end  
          format.html {render action: "contact_us"} 
          format.json {head :no_content}
    end
  end
  
  def confirmation
  end

  def register
  end

  def home
  end
end
