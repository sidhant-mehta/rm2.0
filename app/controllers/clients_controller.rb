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

  def edit_project
  end

  def list_mentors
  end

  def add_mentor
    @mentor = Mentor.new
    
    @sectors=[]
    Sector.all.each_with_index do |s,i|
      @sectors << Sector.find(s)
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mentor }
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
        format.html { render action: "new" }
        format.json { render json: @mentor.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_mentor
  end

  def list_jobs
  end

  def add_job
  end

  def edit_job
  end

  def dashboard
  end

  def profle
  end
end
