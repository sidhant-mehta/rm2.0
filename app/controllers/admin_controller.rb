class AdminController < ApplicationController
  before_filter :authenticate_admin!
  
  def login
  end

  def dashboard
  end

  def adverts
  end

  def team
  end

  def members
  end

  def mentors
  end

  def projects
  end

  def clients
  end

  def jobs
  end

  def employer_profiles
  end
end
