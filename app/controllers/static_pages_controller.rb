class StaticPagesController < ApplicationController
before_filter :authorize, only: [:prototype]

  def home
  end

  def help
  end

  def about
  end

  def investors
  end

  def faq
  end

  def follow
  end

  def prototype
  end

  def jobs
  end
end
