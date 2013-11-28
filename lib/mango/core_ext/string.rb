# Extentions to the core `String` class
#
class String
  # Convert a file name to a Sinatra-compliant template name
  #
  # @example
  #   "blog.haml".templatize              #=> :blog
  #   "blog/home.erb".templatize          #=> :"blog/home"
  #   "page.html.liquid".templatize       #=> :"page.html"
  #   "article/post.html.haml".templatize #=> :"article/post.html"
  #
  # @return [Symbol] A Sinatra-compliant template name
  #
  def templatize
    self.rpartition(".").shift.to_sym
  end
end
