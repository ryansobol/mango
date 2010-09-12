# encoding: UTF-8

module MalformedWhitespaceMatchers
  class ContainTabCharacters
    def matches?(file_name)
      @file_name = file_name

      @failing_lines = []
      File.readlines(@file_name).each_with_index do |line, number|
        @failing_lines << number + 1 if line =~ /\t/
      end

      !@failing_lines.empty?
    end

    def failure_message_for_should
      "expected #{@file_name.inspect} to contain tab characters but has none."
    end

    def failure_message_for_should_not
      "expected #{@file_name.inspect} to not contain tab characters" +
      " but has one or more on lines #{@failing_lines.join(', ')}."
    end
  end

  #################################################################################################

  class ContainExtraSpaces
    def matches?(file_name)
      @file_name = file_name

      @failing_lines = []
      File.readlines(@file_name).each_with_index do |line, number|
        next if line =~ /^\s+#.*\s+\n$/
        @failing_lines << number + 1 if line =~ /\s+\n$/
      end

      !@failing_lines.empty?
    end

    def failure_message_for_should
      "expected #{@file_name.inspect} to contain extra spaces but has none."
    end

    def failure_message_for_should_not
      "expected #{@file_name.inspect} to not contain extra spaces" +
      " but has one or more at the end of lines #{@failing_lines.join(', ')}."
    end
  end

  #################################################################################################

  def contain_tab_characters
    ContainTabCharacters.new
  end

  def contain_extra_spaces
    ContainExtraSpaces.new
  end
end
