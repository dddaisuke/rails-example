class ExamplesController < ApplicationController
  def index
    error!!!!
    render text: 'index'
  end

  def show
    render text: "show #{params[:id]}"
  end
end
