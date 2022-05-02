class Mybook < ApplicationRecord
	has_one_attached :image
	belongs_to :user
   #searchkick
	searchkick word_middle: [:title, :price, :semester, :subject], suggest:[:title]
   validates :title, :price, :year, :semester, :name, :email, :instagram, :subject, :description, presence: true 
   validate :correct_image_type


  def to_s
   title
  end

  after_create do
   mybook = Stripe::Product.create(name: title)
   price = Stripe::Price.create(product: mybook, unit_amount: self.price.to_i * 100, currency: "inr")
   update(stripe_mybook_id: mybook.id, stripe_price_id: price.id)
  end

def to_builder
   Jbuilder.new do |mybook|
      mybook.price stripe_price_id
      mybook.quantity 1
   end
end

 def search_data
   	{

   		title: title,
   		price: price,
   		year: year,
   		semester: semester,
   		subject: subject,
         email: email,
         name: name,
   	}
   end  


private

def correct_image_type
   if image.attached? && !image.content_type.in?(%w(image/jpeg image/png image/jpg image/jiff))
      errors.add(:image, 'must be attached')
   elsif image.attached? == false
      errors.add(:image, 'must be attached')
   end
end


end
