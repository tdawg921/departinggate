class StaticPagesController < ApplicationController
before_filter :authorize

  def home
  end

  def help
  end

  def about
  end
end
