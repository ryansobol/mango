# encoding: UTF-8

class File
  # Convert a file name to a Sinatra-compliant template name
  #
  # @example
  #   File.templatize("blog.haml")  #=> :blog
  #
  # @param [String] name
  # @return [Symbol] A Sinatra-compliant template name
  #
  def self.templatize(name)
    basename(name, '.*').to_sym
  end
end
