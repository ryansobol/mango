require "digest/md5"

module Mango
  # `Mango::FlavoredMarkdown` (MFM) is a subset of GithubFlavoredMarkdown (GFM).  MFM adds a touch
  # seasoning to the standard Markdown (SM) syntax.
  #
  # ## Differences from standard Markdown
  #
  # ### Newlines
  #
  # The biggest difference that MFM introduces is in the handling of linebreaks. With SM you can
  # hard wrap paragraphs of text and they will be combined into a single paragraph. I find this to
  # be the cause of a huge number of unintentional formatting errors. MFM treats newlines in
  # paragraph-like content as real line breaks, which is probably what you intended.
  #
  # The next paragraph contains two phrases separated by a single newline character:
  #
  #     Roses are red
  #     Violets are blue
  #
  # becomes
  #
  # Roses are red  
  # Violets are blue
  #
  # ### Multiple underscores in words
  #
  # It is not reasonable to italicize just part of a word, especially when you're dealing with code
  # and names often appear with multiple underscores. Therefore, MFM ignores multiple underscores
  # in words.
  #
  #     perform_complicated_task
  #     do_this_and_do_that_and_another_thing
  #
  # becomes
  #
  # perform_complicated_task  
  # do_this_and_do_that_and_another_thing
  #
  # @see http://github.github.com/github-flavored-markdown/
  # @see http://daringfireball.net/projects/markdown/syntax
  #
  class FlavoredMarkdown
    # For maximum flavor, add one shake of seasoning to markdown text **before** cooking with a
    # Markdown engine.
    #
    # @example Cooking with BlueCloth
    #
    #   BlueCloth.new(Mango::FlavoredMarkdown.shake(text)).to_html
    #
    # @param [String] text
    # @return [String] Seasoned text that is ready to cook!
    #
    def self.shake(text)
      # Extract pre blocks
      extractions = {}
      text.gsub!(%r{<pre>.*?</pre>}m) do |match|
        md5 = Digest::MD5.hexdigest(match)
        extractions[md5] = match
        "{gfm-extraction-#{md5}}"
      end

      # prevent foo_bar_baz from ending up with an italic word in the middle
      text.gsub!(/(^(?! {4}|\t)\w+_\w+_\w[\w_]*)/) do |x|
        x.gsub("_", '\_') if x.split('').sort.join[0..1] == "__"
      end

      # in very clear cases, let newlines become <br /> tags
      text.gsub!(/^[\w\<][^\n]*\n+/) do |x|
        x =~ /\n{2}/ ? x : (x.strip!; x << "  \n")
      end

      # Insert pre block extractions
      text.gsub!(/\{gfm-extraction-([0-9a-f]{32})\}/) do
        "\n\n" + extractions[$1]
      end

      text
    end

    # Destructively replaces the value of `text` with a shake of `FlavoredMarkdown` text
    #
    # @param [String] text
    # @see FlavoredMarkdown.shake
    def self.shake!(text)
      text.replace shake(text)
    end
  end
end