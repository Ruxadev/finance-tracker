class UserStocksController < ApplicationController

  def create
    stock = Stock.check_db(params[:ticker])
    if stock.blank?
    stock = Stock.new_lookup(params:[ticker])
    stock.save
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "Stock #{stock.name} was successfully added to your portifolio"
    redirect_to my_portifolio_path
  end

  def destroy
    stock = Stock.find(params[:id])
    user_stock = UserStock.where(user_id: current_user.id, stock.id: stock.id).first
    user_stock.destroy
    flash[:notice] = "#{stock.ticker} was successfully remove from portifolio"
    redirect_to my_portifolio_path
  end

end
