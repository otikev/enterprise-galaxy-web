class AdvisersController < ApplicationController

  def show
    @adviser = Adviser.where(:id => params[:id]).first
  end

end
