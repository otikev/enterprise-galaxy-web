class EnterprisesController < ApplicationController

  def show
    @enterprise = Enterprise.where(:id => params[:id]).first
  end

  def dashboard

  end
end
