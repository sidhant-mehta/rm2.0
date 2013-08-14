class MentorsController < ApplicationController
  # GET /mentors
  # GET /mentors.json
 
   
  def index
    @type = "mentor"
    @mentors = Mentor.where(:external => true)
    @sectors = Sector.find(:all, :order=>'name')
    @location = Location.find(:all, :order => 'name')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mentors }
    end
  end

  def search
    @type = "mentor"
     if ( params.has_key?(:mentor_name) )
           @search_name =params[:mentor_name].split(" ")    
     else
            @search_name =""
     end
     
    @search_sector = params[:sector_id]
    @search_closing_date = params[:closing_date]
    @search_location = params[:location]
    #@search_pay_value = params[:pay_value]
    
    @sectors = Sector.find(:all, :order=>'name')
    @location = Location.find(:all, :order => 'name')
    @result_mentors = Mentor.search(@search_name[0], @search_name[1], @search_sector, @search_location, @search_closing_date )
    
  end

  # GET /mentors/1
  # GET /mentors/1.json
  def show
    if (current_member.blank? ) 
        @member =-1
    else
        @member = Member.find(current_member.id).id
    end
    
    @mentor = Mentor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mentor }
    end
  end

  # GET /mentors/new
  # GET /mentors/new.json
  def new
    @mentor = Mentor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mentor }
    end
  end

  # GET /mentors/1/edit
  def edit
    @mentor = Mentor.find(params[:id])
  end

  # POST /mentors
  # POST /mentors.json
  def create
    @mentor = Mentor.new(params[:mentor])
    
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

  # PUT /mentors/1
  # PUT /mentors/1.json
  def update
    @mentor = Mentor.find(params[:id])

    respond_to do |format|
      if @mentor.update_attributes(params[:mentor])
        format.html { redirect_to @mentor, notice: 'Mentor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mentor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mentors/1
  # DELETE /mentors/1.json
  def destroy
    @mentor = Mentor.find(params[:id])
    @mentor.destroy

    respond_to do |format|
      format.html { redirect_to mentors_url, alert: "Mentor was successfully removed." }
      format.json { head :no_content }
    end
  end
end
