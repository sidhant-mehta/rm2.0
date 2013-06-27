class ProjectsController < ApplicationController
  # GET /projects
  # GET /projects.json
  
   def apply
    params[:member_id].each do |key,value|
        @member_id = value.to_i
    end 
    
    params[:project_id].each do |key,value|
        @project_id = value.to_i
    end
  
    if can_member_make_application_checks (@member_id)
       @application = MemberProjectApplication.new(:member_id => @member_id, :project_id => @project_id, :status => "Applied")
       
       if @application.save    
          redirect_to projects_path,  :notice => "Your application has been made successfully."
          #TODO send email to HR => project name and id, member name and id
       else
          redirect_to projects_path, :notice => @application.errors
       end
   else
         redirect_to projects_path, :notice => "You must be logged in to make appilcations."
    end
  end
  
  def index
    @type = "project" 
    @projects = Project.all
    @sectors = Sector.find(:all, :order=>'name')
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  def search
    @type = "project"
     if ( params.has_key?(:project_name) )
           @search_name =params[:project_name]    
     else
            @search_name =""
     end
     
    @search_sector = params[:sector_id]
    @search_closing_date = params[:closing_date]
    @search_pay_value = params[:pay_value]
    
    @sectors = Sector.find(:all, :order=>'name')
    @result_projects = Project.search(@search_name[0], @search_sector, @search_closing_date, @search_pay_value )
    
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    if (current_member.blank? ) 
        @member =-1
    else
        @member = Member.find(current_member.id).id
    end
    
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end
end
