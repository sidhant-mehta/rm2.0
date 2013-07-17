class ClientsController < ApplicationController
    before_filter :authenticate_client!
    layout 'admin'
  
def clean_select_multiple_params hash = params
  hash.each do |k, v|
    case v
    when Array
       v.reject!(&:blank?)
       v.join(',')
    when Hash then clean_select_multiple_params(v)
    end
  end
end  
  
  
  def list_projects
  end

  def add_project
    
  end
  
  def create_project
    
  end

  def edit_project
  end

  def list_mentors
    if (EmployerProfile.exists?(current_client.id) && !EmployerProfile.find(current_client.id).name.blank?)
        @mentors = Mentor.where(:organisation => EmployerProfile.find(current_client.id).name) #TODO Find only ones from certain organisation. 
        @sectors = Sector.find(:all, :order=>'name')
        
        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @mentors }
        end

    else
        respond_to do |format|
              format.html {redirect_to clients_profile_path, alert:"You must complete your profile before adding, editing or viewing any Mentors or Projects."}
          end
    end

  end

  def new_mentor
    if (EmployerProfile.exists?(current_client.id) && !EmployerProfile.find(current_client.id).name.blank?)
          @mentor = Mentor.new
          @mentor.organisation = EmployerProfile.find(current_client.id).name
          @sectors=[]
          Sector.all.each_with_index do |s,i|
            @sectors << Sector.find(s)
          end
          
          respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @mentor }
          end
    else
          respond_to do |format|
              format.html {redirect_to clients_profile_path, alert:"You must complete your profile before adding, editing or viewing any Mentors or Projects."}
          end
    end

  end

  # POST /create_mentor
  # POST /create_mentor.json
  def create_mentor
    m = clean_select_multiple_params params[:mentor]
    m["sector_ids"] = m["sector_ids"].join(',')
    @mentor = Mentor.new(m)
    
    respond_to do |format|
      if @mentor.save
        format.html { redirect_to @mentor, notice: 'Mentor was successfully created.' }
        format.json { render json: @mentor, status: :created, location: @mentor }
      else
        @error_str = ""
        @mentor.errors.each do |field, msg|
              @error_str = @error_str + msg + " "
        end
        
        flash.now[:alert] = @error_str
        
        format.html { render action: "new_mentor" }
        #format.json { render json: @mentor.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # GET /mentors/1/edit
  def edit_mentor
    @mentor = Mentor.find(params[:id])
    
  end

  def update_mentor
      m = clean_select_multiple_params params[:mentor]
      m["sector_ids"] = m["sector_ids"].join(',')

      @mentor = Mentor.find(m["id"])
         
       
    respond_to do |format|
      if @mentor.update_attributes(params[:mentor])
        format.html { redirect_to @mentor, notice: 'Mentor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit_mentor" }
        format.json { render json: @mentor.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def list_jobs
  end

  def add_job
  end

  def edit_job
  end

  def dashboard
  end

  def profile # employer profile
    #get the employer profile record that is already in place. Or create a new one which has the same ID as the current client id, as this one client is responsible for the company.
    if (!EmployerProfile.exists?(current_client.id))
        @employer_profile = EmployerProfile.new
        @employer_profile.id = current_client.id
        @employer_profile.save
    end
    
    @employer_profile = EmployerProfile.find(current_client.id) 
  
  end

  def profile_update
    #TODO NEED TO HAVE SOME SORT OF CHECK FOR THE COMPANY NAME ENTERED AND THE ORGANISATION SO NO ONE CAN ADD ANY OLD COMPANY. TABLE OF COMPANY VS EMAIL ADD?
       @employer_profile = EmployerProfile.find(current_client.id)
       
       respond_to do |format|
         if @employer_profile.update_attributes(params[:employer_profile]) 
           format.html { redirect_to clients_profile_path, notice: "Profile was successfully updated."}
           format.json{head :no_content}
         else
            @error_str = ""
            @employer_profile.errors.each do |field, msg|
              @error_str = @error_str + msg + " "
            end
            flash[:alert] = @error_str
            
            format.html { render action: "profile"}
         end
       end
  end 
  
end
