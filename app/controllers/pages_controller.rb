class PagesController < ApplicationController

  def index

  end

  def user_form

  end

  def about

  end

  def help

  end

  def error

    @error = params[:error]

  end

  def quote

    @quote = params[:quote]

  end

  def retrieve_form

  end

end
