class Order < ActiveRecord::Base
  attr_accessible :address, :card_expires_on, :card_type, :city, :country, :first_name, :ip_address, :last_name, :zip_code

  has_many :transactions, :class_name => "OrderTransaction"

  attr_accessor :card_number, :card_verification

  validate :validate_card, on: :create

  BILL_AMOUNT = 1200
  PAYMENT_TYPES = [["Visa", "visa"]]
  COUNTRIES = ["Norge", "Sverige", "Danmark"]

  def full_name
    return first_name + " " + last_name
  end

  def purchase
  	response = GATEWAY.purchase(BILL_AMOUNT, credit_card, purchase_options)
  	transactions.create!(:action => "purchase", :amount => BILL_AMOUNT, :response => response)
  	response.success?
  end

  private

  def purchase_options
  	{
  		:ip => ip_address,
  		:billing_address => {
  			:name => "Thomas Stroemme",
  			:address1 => "Badebakken 16",
  			:city => "Oslo",
  			:country => "NO",
  			:zip => "0467"
  		}
  	}
  end

  def paypal_purchase
    {
      :ip => ip_address,
      :billing_address => {
        :name => full_name,
        :address1 => address,
        :city => city,
        :country => country,
        :zip => zip_code
      }
    }
  end

  def validate_card
  	unless credit_card.valid?
  		credit_card.errors.full_messages.each do |message|
  			errors[:base] << message
  		end
  	end
  end

  def credit_card
  	@credit_card ||= ActiveMerchant::Billing::CreditCard.new(
  		:brand => card_type,
  		:number => card_number,
  		:verification_value => card_verification,
  		:month => card_expires_on.month,
  		:year => card_expires_on.year,
  		:first_name => first_name,
  		:last_name => last_name
  		)
  end
end
