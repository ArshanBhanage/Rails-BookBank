class Mybook < ApplicationRecord
	has_one_attached :image
	belongs_to :user
	searchkick word_middle: [:title, :price, :semester, :subject]
   validates :title, :price, presence: true 

 #include Tire::Model::Search
 #include Tire::Model::Callbacks

#def self.search(params)
#	tire.search(load: true) do
#		query { string params[:query] } if params[:query].present?	
#	end
#end


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
   		#year: year,
   		semester: semester,
   		subject: subject,
         email: email,
   	}
   end  

end
