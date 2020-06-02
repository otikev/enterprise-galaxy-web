class EnterprisesController < ApplicationController
  def index

  end

  def new

  end

  def success

  end

  def show
    @enterprise = Enterprise.where(:id => params[:id]).first
  end

  def create

  end
end
