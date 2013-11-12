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

  end

  def quote

    @quote = params[:quote]

  end

end
