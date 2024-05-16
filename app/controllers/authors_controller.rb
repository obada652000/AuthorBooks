class AuthorsController < ApplicationController
  before_action :set_author, only: [:show]
  before_action :authenticate_author!

  def index
    @filterrific = initialize_filterrific(
      Author,
      params[:filterrific]
     ) || return

    @authors = @filterrific.find

    respond_to do |format|
      format.html
    end
  end

  def show
  end

  private

  def set_author
    @author = Author.find(params[:id])
  end
end
