class ExamplesController < ApplicationController
  def index
    render text: 'index'
  end

  def show
    render text: "show #{params[:id]}"
  end
end
