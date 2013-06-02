class MentorsController < ApplicationController
  # GET /mentors
  # GET /mentors.json
 
  def apply
    params[:member_id].each do |key,value|
        @member_id = value.to_i
    end 
    
    params[:mentor_id].each do |key,value|
        @mentor_id = value.to_i
    end
  
    if can_member_make_application_checks (@member_id)
       @application = MemberMentorApplication.new(:member_id => @member_id, :mentor_id => @mentor_id, :status => "Applied")
       
       if @application.save    
          redirect_to mentors_path,  :notice => "Your application has been made successfully."
          #TODO send email to HR => mentor name and id, member name and id
       else
          redirect_to mentors_path, :notice => @application.errors
       end
   else
         redirect_to mentors_path, :notice => "You must be logged in to make appilcations."
    end
  end
  
  def index
    @mentors = Mentor.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mentors }
    end
  end

  def search
    
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
      format.html { redirect_to mentors_url }
      format.json { head :no_content }
    end
  end
end
