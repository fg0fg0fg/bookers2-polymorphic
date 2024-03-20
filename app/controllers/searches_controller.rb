class SearchesController < ApplicationController
  def search
    @range = params[:range]#検索モデル
    @word = params[:word]#検索ワード
    if @range == "User"#UserかBook
      @users = User.looks(params[:search], @word)
    else
      @books = Book.looks(params[:search], @word)
    end
  end
end
#params[:search]検索方法