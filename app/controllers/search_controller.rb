class SearchController < ApplicationController
	def search
    if params[:q].nil?
      @mybooks = []
    else
      @mybooks = Mybook.search params[:q]
      end
  end
end