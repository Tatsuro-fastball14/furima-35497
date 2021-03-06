class PurchaseAddress

  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :municipalities, :address, :building, :phone_number,:card_token,:user_id,:item_id
  


  with_options presence: true do
    validates :user_id
    validates :item_id
  
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    VALID_PHONE_NUMBER_REGEX =/\A\d{10,11}\z/
    validates :phone_number,format: { with: VALID_PHONE_NUMBER_REGEX }
    validates :municipalities
    validates :address
    validates :card_token
    

  end
  
  validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}



  


  def save
    purchases = Purchase.create(user_id:user_id,item_id:item_id)
    ShippingAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, municipalities: municipalities, address: address, building: building,phone_number: phone_number,purchase_id:purchases.id)
  end


end

  

