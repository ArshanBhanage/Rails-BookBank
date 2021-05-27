json.extract! mybook, :id, :title, :year, :price, :image, :user_id :created_at, :updated_at
json.url mybook_url(mybook, format: :json)
