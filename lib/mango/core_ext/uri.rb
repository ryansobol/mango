# Extentions to the core `URI` module
#
module URI
  # Given a URI path, determine whether or no it looks like a directory path
  #
  # @param [String] uri_path
  # @return [Boolean] `true` if the path is empty or has a trailing `/`, otherwise `false`
  #
  def self.directory?(uri_path)
    uri_path.empty? || uri_path[-1] == "/"
  end
end
