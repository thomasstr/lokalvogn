class OrderTransaction < ActiveRecord::Base
  attr_accessible :action, :amount, :authorization, :message, :order_id, :params, :success

  serialize :params
  belongs_to :order

  def response=(response)
  	self.success = response.success?
  	self.authorization = response.authorization
  	self.message = response.message
  	self.params = response.params
  rescue ActiveMerchant::ActiveMerchantError => e
  	self.success = false
  	self.authorization = nil
  	self.message = e.message
  	self.params = {}
  end

  def cents_to_price
    amount/100
  end
end
