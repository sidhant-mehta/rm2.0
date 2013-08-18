class EmployerProfilesController < ApplicationController
  # GET /employer_profiles
  # GET /employer_profiles.json
before_filter :setVars

def setVars
    @type = "employer"
    @sectors=[]
    Sector.all.each_with_index do |s,i|
      @sectors << Sector.find(s)
    end
        @location = Location.find(:all, :order => 'name')

end
#------------------------------------------------

  def search
    if ( params.has_key?(:employer_name) )
           @search_name =params[:employer_name]    
     else
          @search_name =""
   end
   
   @employer_profiles = EmployerProfile.search(@search_name)
   
   render "index"
   
  end

  def index
    @employer_profiles = EmployerProfile.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @employer_profiles }
    end
  end

  # GET /employer_profiles/1
  # GET /employer_profiles/1.json
  def show
    @employer_profile = EmployerProfile.find(params[:id])
    @mentors = Mentor.where(:organisation => @employer_profile.name)
    @projects = Project.where(:organisation => @employer_profile.name)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @employer_profile }
    end

  end

  
  # GET /employer_profiles/new
  # GET /employer_profiles/new.json
  def new
    @employer_profile = EmployerProfile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @employer_profile }
    end
  end

  # GET /employer_profiles/1/edit
  def edit
    @employer_profile = EmployerProfile.find(params[:id])
  end

  # POST /employer_profiles
  # POST /employer_profiles.json
  def create
    @employer_profile = EmployerProfile.new(params[:employer_profile])

    respond_to do |format|
      if @employer_profile.save
        format.html { redirect_to @employer_profile, notice: 'Organisation profile was successfully created.' }
        format.json { render json: @employer_profile, status: :created, location: @employer_profile }
      else
        format.html { render action: "new" }
        format.json { render json: @employer_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /employer_profiles/1
  # PUT /employer_profiles/1.json
  def update
    @employer_profile = EmployerProfile.find(params[:id])

    respond_to do |format|
      if @employer_profile.update_attributes(params[:employer_profile])
        format.html { redirect_to @employer_profile, notice: 'Organisation profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @employer_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employer_profiles/1
  # DELETE /employer_profiles/1.json
  def destroy
    @employer_profile = EmployerProfile.find(params[:id])
    @employer_profile.destroy

    respond_to do |format|
      format.html { redirect_to employer_profiles_url }
      format.json { head :no_content }
    end
  end
end
