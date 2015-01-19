class BookshelvesController < ApplicationController
  before_action :set_bookshelf, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @bookshelves = Bookshelf.where(user_id: current_user.id).all
  end

  def show
    tag_id = Tag.find(Bookshelf.find(params[:id])).tag_id
    @books = tag_id.books.order(params[:sort] || "created_at" + " DESC").search(name_cont: params[:name], author_cont: params[:author], publisher_cont: params[:publisher]).result.paginate(page: params[:page], per_page: 20)
  end

  def edit
    @book = Book.find(params[:id])
    @tag = @book.tags.all
  end

  def update
    book = Book.find(params[:id])

    if book.update(book_params)
      book.tags.delete_all
      params[:tags].each do |t|
        Tag.del_space(t)
        unless t.empty?
          tag = Tag.find_by(name: t) || Tag.new(name: t).tap(&:save)
          book.tags << tag
        end
      end
      redirect_to '/books/'
    else
      redirect_to 'edit'
    end

  end

  def new
    @book = Book.new
    @tag = Tag.all
  end

  def create
    book = Book.new(book_params)
    file = params['@book']['upload_file']
    file_path = Settings.download.path + '/' + file.original_filename
    book['path'] = file_path

    pdf = Magick::ImageList.new(file.path + '[0]')
    pdf = pdf.resize(Settings.books.width,  Settings.books.width * pdf.rows / pdf.columns)
    book['thumbnail'] = pdf.to_blob do
      self.format = 'jpg'
    end

    f = File.new(file.tempfile.path, "rb").read
    File.open(file_path, 'wb') do |of|
      of.write(f)
    end

    if book.save
      params[:tags].each do |t|
        Tag.del_space(t)
        unless t.empty?
          tag = Tag.find_by(name: t) || Tag.new(name: t).tap(&:save)
          book.tags << tag
        end
      end
      redirect_to '/books/'
    else
      render 'new'
    end
  end

  def destroy
    book = Book.find(params[:id])
    Tagging.delete_all(book_id: book.id)
    File.delete(book.path)
    book.destroy

    redirect_to '/books/'
  end

  def get_thumbnail
    book = Book.find(params[:id])
    send_data book.thumbnail, disposition: 'inline', type: 'image/jpg'
  end

  def download_file
    pdf = Book.find(params[:id])
    send_file pdf.path, type: 'image/pdf'
  end

  private
  def book_params
    params.require(:@book).permit(:name, :author, :publisher, :category_id, :price)
  end
end
