class UsersController < ApplicationController
  def my_portifolio
    @tracked_stocks = current_user.stocks
  end
end
