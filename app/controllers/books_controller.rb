class BooksController < ApplicationController
  def index
    @books = Book.by_name(params[:name]).by_author([:author]).by_publisher(params[:publisher]).paginate(page: params[:page], per_page: 20)
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      redirect_to '/books/'
    else
      redirect_to 'edit'
    end

  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    file = params['@book']['upload_file']
    file_path = Settings.download.path + '/' + file.original_filename
    @book['path'] = file_path

    pdf = Magick::ImageList.new(file.path + '[0]')
    pdf = pdf.resize(Settings.books.width,  Settings.books.width * pdf.rows / pdf.columns)
    @book['thumbnail'] = pdf.to_blob do
      self.format = 'jpg'
    end

    f = File.new(file.tempfile.path, "rb").read
    File.open(file_path, 'wb') do |of|
      of.write(f)
    end

    if @book.save
      redirect_to '/books/'
    else
      render 'new'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy

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
