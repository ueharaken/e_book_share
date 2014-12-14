class TagsController < ApplicationController
  def index
    @tag = Tag.new
  end
  
  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if(@tag.save)
      redirect_to '/tags'
    else
      redirect_to '/tags'
    end
  end

  def destroy
    tag = Tag.find(params[:id])
    tag.destroy

    redirect_to '/tags/'
  end

  def return_json_tags
    render :json => Tag.all
  end

  private
  def tag_params
    params.require(:@tag).permit(:name)
  end
end
