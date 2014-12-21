class TagsController < ApplicationController
  skip_before_filter :verify_authenticity_token , only: [:update]

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

  def update
    @tag= Tag.find(params[:id])

    if @tag.update(tag_params)
      redirect_to '/tags/'
    else
      redirect_to '/tags/'
    end

  end

  def destroy
    tag = Tag.find(params[:id])
    Tagging.delete_all(tag_id: tag.id)
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
