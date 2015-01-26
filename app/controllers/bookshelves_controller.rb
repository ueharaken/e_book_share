class BookshelvesController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookshelves = User.find(current_user.id).tags.all
  end

  def new 
    @bookshelf = Bookshelf.new
  end

  def create
    params[:tag_id].each do |t|
      bookshelf = Bookshelf.new({user_id: current_user.id, tag_id: t})
      bookshelf.save
    end
    redirect_to bookshelves_path
  end

  def destroy
    Bookshelf.delete_all({user_id: current_user.id, tag_id: params[:id]})
    redirect_to bookshelves_path
  end

  def return_json_unfav_tags
    tag = Tag.where('NOT id IN (SELECT tag_id FROM bookshelves where user_id = ?)', current_user.id)
    render :json => tag
  end

  private
  def bookshelf_params
    params.require(:@bookshelf).permit(:tag_id, :user_id)
  end
end
