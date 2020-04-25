class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  private
  def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def load_order
    puts "USER = #{@user}"
    #binding.pry
    #@order = Order.find_or_initialize_by(id: session[:order_id], status: "unsubmitted", user_id: session[:user_id])
    @order = Order.find_or_initialize_by(id: session[:order_id], status: "unsubmitted")
    @order.user_id = session[:user_id] #if session[:user_id].exists?

    if @order.new_record?
      #binding.pry
      @order.save!
      session[:order_id] = @order.id
    end
  end
end
