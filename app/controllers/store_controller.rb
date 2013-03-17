#encoding: utf-8
class StoreController < ApplicationController
  def index
  	@products = Product.order("created_at desc")
  end

  def cart
  	@cart = current_cart
  	if @cart.line_items.empty?
  		redirect_to store_url, notice: "Handlevognen din er tom."
  	end
  end

  def why_us
  	
  end
end
