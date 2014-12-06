class BooksController < ApplicationController
  def index
  end

  def show
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    file = params['@book']['upload_file']
    file_path = 'pdf/' + file.original_filename
    @book['path'] = file_path

    pdf = Magick::ImageList.new(file.path + '[0]')
    pdf = pdf.resize(300,  300 * pdf.rows / pdf.columns)
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
      render '/books/new'
    end
  end

  private
  def book_params
    params.require(:@book).permit(:name, :author, :publisher, :category_id, :price)
  end
end
