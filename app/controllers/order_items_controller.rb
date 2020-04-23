class OrderItemsController < ApplicationController
  before_action :set_order_item, only: [:show, :edit, :destroy]
  
  #Only before the 'create' method, run the 'load_order' method
  before_action :load_order, only: [:create]

  # GET /order_items/1/edit
  def edit
  end

  # POST /order_items
  # POST /order_items.json
  def create
    @order_item = @order.order_items.find_or_initialize_by(product_id: params[:product_id])
    @order_item.quantity = @order_item.quantity + 1

    respond_to do |format|
      if @order_item.save
        format.html { redirect_to @order, notice: 'Successfully added product to cart.' }
        format.json { render :show, status: :created, location: @order_item }
      else
        format.html { render :new }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_items/1
  # PATCH/PUT /order_items/1.json
  # def update
  #  @order = Order.find_by(id: session[:order_id])
  #  #puts params[:id]
  #  @order_item = OrderItem.find_by(id: params[:id])
  #  puts @order_item.product.title
  #  #puts @order_item.quantity
  #  #puts @order_item
  #   if (params[:order_item][:quantity].to_i == 0)
  #     @order_item.destroy
  #     #format.html { redirect_to order_url, notice: 'Removed item from order.' }
  #     format.html { redirect_to @order, notice: 'Removed item from order.' }
  #     format.json { render :show, status: :ok, location: @order_item }
  #   else
  #     respond_to do |format|
  #       #@order_item = OrderItem.find_by(id: session[:order_id])
  #       if @order_item.update(order_item_params)
  #         #format.html { redirect_to order_url, notice: 'Order item was successfully updated.' }
  #         format.html { redirect_to @order, notice: 'Order item was successfully updated.' }
  #         format.json { render :show, status: :ok, location: @order_item }
          
  #       else
  #         format.html { render :edit }
  #         format.json { render json: @order.errors, status: :unprocessable_entity }
  #       end
  #     end
  #   end
  # end
  def update
    @order = Order.find_by(id: session[:order_id])
    @order_item = OrderItem.find_by(id: params[:id])

    respond_to do |format|
      if (params[:order_item][:quantity].to_i == 0)
        @order_item.destroy
        #format.html { redirect_to order_url, notice: 'Removed item from order.' }
        format.html { redirect_to @order, notice: 'Removed item from order.' }
        format.json { render :show, status: :ok, location: @order_item }
      elsif  @order_item.update(order_item_params)
        #format.html { redirect_to order_url, notice: 'Order item was successfully updated.' }
        format.html { redirect_to @order, notice: 'Order item was successfully updated.' }
        format.json { render :show, status: :ok, location: @order_item }   
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_items/1
  # DELETE /order_items/1.json
  def destroy
    @order_item.destroy
    @order = Order.find_by(id: session[:order_id])
    respond_to do |format|
      format.html { redirect_to @order, notice: 'Order item was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_item
      @order_item = OrderItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_item_params
      params.require(:order_item).permit(:product_id, :order_id, :quantity)
    end

    def load_order
      @order = Order.find_or_initialize_by(id: session[:order_id], status: "unsubmitted")
      if @order.new_record?
        @order.save!
        session[:order_id] = @order.id
      end
    end 
end
