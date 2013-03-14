class Purchase < ActiveRecord::Base
  attr_accessible :amount, :avs_code, :cvv2_code, :token, :transaction_id, :response
  before_save :set_token
  
  def to_param
    self.token
  end
  
  def response=(info)
    # CC Response
    %w(cvv2_code avs_code amount transaction_id).each do |f|
      self.send("#{f}=", info.params[f])
    end
    # Express Checkout Response
    self.amount = info.params['gross_amount'] if info.params['gross_amount']
  end
  
  protected
  
  def set_token
    self.token = ActiveSupport::SecureRandom.hex if token.blank?
  end
end
