require "spec_helper"

describe Mango::ContentPage do
  describe "given data with header and Haml body, using the Haml engine" do
    before(:all) do
      @expected_data = <<-EOS
---
title: Delicious Cake
view: blog.haml
engine: Will not persist
data: Will not persist
content: Will also not persist
---
%h1= page.title
%p So delicious!
%p= page.view
%p= page.engine
%p= page.content
%p= page.data
%p= page.body
      EOS
      @expected_engine = Tilt::HamlTemplate
      @page = Mango::ContentPage.new(data: @expected_data, engine: @expected_engine)
    end

    it "has the correct number of attributes" do
      expect(@page.attributes.size).to eq(6)
    end

    it "has the correct title attribute" do
      expect(@page.title).to eq("Delicious Cake")
    end

    it "has the correct view attribute" do
      expect(@page.view).to eq("blog.haml")
    end

    it "has the correct engine attribute" do
      expect(@page.engine).to eq(@expected_engine)
    end

    it "has the correct data attribute" do
      expect(@page.data).to eq(@expected_data)
    end

    it "has the correct body attribute" do
      expect(@page.body).to eq <<-EOS
%h1= page.title
%p So delicious!
%p= page.view
%p= page.engine
%p= page.content
%p= page.data
%p= page.body
      EOS
    end

    it "has the correct content attribute" do
      expect(@page.content).to eq <<-EOS
<h1>Delicious Cake</h1>
<p>So delicious!</p>
<p>blog.haml</p>
<p>#{@expected_engine}</p>
<p></p>
<p>
  ---
  title: Delicious Cake
  view: blog.haml
  engine: Will not persist
  data: Will not persist
  content: Will also not persist
  ---
  %h1= page.title
  %p So delicious!
  %p= page.view
  %p= page.engine
  %p= page.content
  %p= page.data
  %p= page.body
</p>
<p>
  %h1= page.title
  %p So delicious!
  %p= page.view
  %p= page.engine
  %p= page.content
  %p= page.data
  %p= page.body
</p>
      EOS
    end
  end

  #################################################################################################

  describe "given data with header and Markdown body, using the Markdown engine" do
    before(:all) do
      @expected_data = <<-EOS
---
title: Chocolate Pie
view: blog.haml
---
### Sweet and crumbly!
      EOS
      @expected_engine = Tilt::BlueClothTemplate
      @page = Mango::ContentPage.new(data: @expected_data, engine: @expected_engine)
    end

    it "has the correct number of attributes" do
      expect(@page.attributes.size).to eq(6)
    end

    it "has the correct title attribute" do
      expect(@page.title).to eq("Chocolate Pie")
    end

    it "has the correct view attribute" do
      expect(@page.view).to eq("blog.haml")
    end

    it "has the correct engine attribute" do
      expect(@page.engine).to eq(@expected_engine)
    end

    it "has the correct data attribute" do
      expect(@page.data).to eq(@expected_data)
    end

    it "has the correct body attribute" do
      expect(@page.body).to eq("### Sweet and crumbly!\n")
    end

    it "has the correct content attribute" do
      expect(@page.content).to eq("<h3>Sweet and crumbly!</h3>")
    end
  end

  #################################################################################################

  describe "given data with header and ERB body, using the ERB engine" do
    before(:all) do
      @expected_data = <<-EOS
---
title: Cake Pops
view: blog.haml
---
<h1><%= page.title %></h1>
<p>Did you mean <%= 'crack' %> pops?</p>
<p><%= page.view %></p>
<p><%= page.content %></p>
<pre>
<%= page.data %>
</pre>
<pre>
<%= page.body %>
</pre>
      EOS
      @expected_engine = Tilt::ERBTemplate
      @page = Mango::ContentPage.new(data: @expected_data, engine: @expected_engine)
    end

    it "has the correct number of attributes" do
      expect(@page.attributes.size).to eq(6)
    end

    it "has the correct title attribute" do
      expect(@page.title).to eq("Cake Pops")
    end

    it "has the correct view attribute" do
      expect(@page.view).to eq("blog.haml")
    end

    it "has the correct engine attribute" do
      expect(@page.engine).to eq(@expected_engine)
    end

    it "has the correct data attribute" do
      expect(@page.data).to eq(@expected_data)
    end

    it "has the correct body attribute" do
      expect(@page.body).to eq <<-EOS
<h1><%= page.title %></h1>
<p>Did you mean <%= 'crack' %> pops?</p>
<p><%= page.view %></p>
<p><%= page.content %></p>
<pre>
<%= page.data %>
</pre>
<pre>
<%= page.body %>
</pre>
      EOS
    end

    it "has the correct content attribute" do
      expect(@page.content).to eq <<-EOS
<h1>Cake Pops</h1>
<p>Did you mean crack pops?</p>
<p>blog.haml</p>
<p></p>
<pre>
---
title: Cake Pops
view: blog.haml
---
<h1><%= page.title %></h1>
<p>Did you mean <%= 'crack' %> pops?</p>
<p><%= page.view %></p>
<p><%= page.content %></p>
<pre>
<%= page.data %>
</pre>
<pre>
<%= page.body %>
</pre>
</pre>
<pre>
<h1><%= page.title %></h1>
<p>Did you mean <%= 'crack' %> pops?</p>
<p><%= page.view %></p>
<p><%= page.content %></p>
<pre>
<%= page.data %>
</pre>
<pre>
<%= page.body %>
</pre>
</pre>
      EOS
    end
  end

  #################################################################################################

  describe "given data with header and Liquid body, using the Liquid engine" do
    before(:all) do
      @expected_data = <<-EOS
---
title: Cake Pops
view: blog.liquid
---
<h1>{{ page.title }}</h1>
<p>Did you mean {{ 'crack' }} pops?</p>
<p>{{ page.view }}</p>
<p>{{ page.content }}</p>
<pre>
{{ page.data }}
</pre>
<pre>
{{ page.body }}
</pre>
      EOS
      @expected_engine = Tilt::LiquidTemplate
      @page = Mango::ContentPage.new(data: @expected_data, engine: @expected_engine)
    end

    it "has the correct number of attributes" do
      expect(@page.attributes.size).to eq(6)
    end

    it "converts itself to liquid format" do
      expect(@page.attributes).to eq(@page.to_liquid)
    end

    it "has the correct title attribute" do
      expect(@page.title).to eq("Cake Pops")
    end

    it "has the correct view attribute" do
      expect(@page.view).to eq("blog.liquid")
    end

    it "has the correct engine attribute" do
      expect(@page.engine).to eq(@expected_engine)
    end

    it "has the correct data attribute" do
      expect(@page.data).to eq(@expected_data)
    end

    it "has the correct body attribute" do
      expect(@page.body).to eq <<-EOS
<h1>{{ page.title }}</h1>
<p>Did you mean {{ 'crack' }} pops?</p>
<p>{{ page.view }}</p>
<p>{{ page.content }}</p>
<pre>
{{ page.data }}
</pre>
<pre>
{{ page.body }}
</pre>
      EOS
    end

    it "has the correct content attribute" do
      expect(@page.content).to eq <<-EOS
<h1>Cake Pops</h1>
<p>Did you mean crack pops?</p>
<p>blog.liquid</p>
<p></p>
<pre>
---
title: Cake Pops
view: blog.liquid
---
<h1>{{ page.title }}</h1>
<p>Did you mean {{ 'crack' }} pops?</p>
<p>{{ page.view }}</p>
<p>{{ page.content }}</p>
<pre>
{{ page.data }}
</pre>
<pre>
{{ page.body }}
</pre>

</pre>
<pre>
<h1>{{ page.title }}</h1>
<p>Did you mean {{ 'crack' }} pops?</p>
<p>{{ page.view }}</p>
<p>{{ page.content }}</p>
<pre>
{{ page.data }}
</pre>
<pre>
{{ page.body }}
</pre>

</pre>
      EOS
    end
  end

  #################################################################################################

  describe "given data with header only, using the default engine" do
    before(:all) do
      @expected_data = <<-EOS
---
title: Delicious Cake
view: blog.haml
---
      EOS
      @page = Mango::ContentPage.new(data: @expected_data)
    end

    it "has the correct number of attributes" do
      expect(@page.attributes.size).to eq(6)
    end

    it "has the correct title attribute" do
      expect(@page.title).to eq("Delicious Cake")
    end

    it "has the correct view attribute" do
      expect(@page.view).to eq("blog.haml")
    end

    it "has the correct engine attribute" do
      expect(@page.engine).to eq(Mango::ContentPage::DEFAULT_ATTRIBUTES["engine"])
    end

    it "has the correct data attribute" do
      expect(@page.data).to eq(@expected_data)
    end

    it "has the correct body attribute" do
      expect(@page.body).to be_empty
    end

    it "has the correct content attribute" do
      expect(@page.content).to be_empty
    end
  end

  #################################################################################################

  describe "given data with Markdown body only, using the default engine" do
    before(:all) do
      @expected_data = <<-EOS
### So delicious!
EOS
      @page = Mango::ContentPage.new(data: @expected_data)
    end

    it "has the correct number of attributes" do
      expect(@page.attributes.size).to eq(5)
    end

    it "has the correct view attribute" do
      expect(@page.view).to eq("page.haml")
    end

    it "has the correct engine attribute" do
      expect(@page.engine).to eq(Mango::ContentPage::DEFAULT_ATTRIBUTES["engine"])
    end

    it "has the correct data attribute" do
      expect(@page.data).to eq(@expected_data)
    end

    it "has the correct body attribute" do
      expect(@page.body).to eq(@expected_data)
    end

    it "has the correct content attribute" do
      expect(@page.content).to eq("<h3>So delicious!</h3>")
    end
  end

  #################################################################################################

  describe "given data with empty header only, using the default engine" do
    before(:all) do
      @expected_data = <<-EOS
---
---
EOS
      @page = Mango::ContentPage.new(data: @expected_data)
    end

    it "saves the data" do
      expect(@page.data).to eq(@expected_data)
    end

    it "has the correct number of attributes" do
      expect(@page.attributes.size).to eq(5)
    end

    it "has the correct view attribute" do
      expect(@page.view).to eq("page.haml")
    end

    it "has the correct engine attribute" do
      expect(@page.engine).to eq(Mango::ContentPage::DEFAULT_ATTRIBUTES["engine"])
    end

    it "has the correct data attribute" do
      expect(@page.data).to eq(@expected_data)
    end

    it "has the correct body attribute" do
      expect(@page.body).to be_empty
    end

    it "has the correct content attribute" do
      expect(@page.content).to be_empty
    end
  end

  #################################################################################################

  describe "given no data" do
    before(:all) do
      @page = Mango::ContentPage.new
    end

    it "saves the data" do
      expect(@page.data).to eq("")
    end

    it "has the correct number of attributes" do
      expect(@page.attributes.size).to eq(5)
    end

    it "has the correct view attribute" do
      expect(@page.view).to eq("page.haml")
    end

    it "has the correct engine attribute" do
      expect(@page.engine).to eq(Mango::ContentPage::DEFAULT_ATTRIBUTES["engine"])
    end

    it "has the correct data attribute" do
      expect(@page.data).to be_empty
    end

    it "has the correct body attribute" do
      expect(@page.body).to be_empty
    end

    it "has the correct content attribute" do
      expect(@page.content).to be_empty
    end
  end

  #################################################################################################

  describe "given data with an invalid title attribute within the header" do
    before(:all) do
      @expected_data = <<-EOS
---
title: WARNING: This needs quotes
---
EOS
    end

    it "raises an exception" do
      expected_message = "(<unknown>): mapping values are not allowed in this context at line 2 column 15"
      expect {
        Mango::ContentPage.new(data: @expected_data)
      }.to raise_exception(Mango::ContentPage::InvalidHeaderError, expected_message)
    end
  end

  #################################################################################################

  describe "given data with an invalid header" do
    before(:all) do
      @expected_data = <<-EOS
---
This is not a Hash
---
EOS
    end

    it "raises an exception" do
      expected_message = 'Cannot parse header -- "This is not a Hash"'
      expect {
        Mango::ContentPage.new(data: @expected_data)
      }.to raise_exception(Mango::ContentPage::InvalidHeaderError, expected_message)
    end
  end

  #################################################################################################

  describe "given no data, using an unknown engine" do
    before(:all) do
      @unknown_engine = :unknown
    end

    it "raises an exception" do
      expected_message = "Cannot find registered content engine -- unknown"
      expect {
        Mango::ContentPage.new(engine: @unknown_engine)
      }.to raise_exception(ArgumentError, expected_message)
    end
  end

  #################################################################################################

  describe "given data with seasonable Markdown body, using the default engine" do
    before(:all) do
      data = <<-EOS
Mango is like a drug.
You must have more and more and more of the Mango
until there is no Mango left.
Not even for Mango!
      EOS

      @page = Mango::ContentPage.new(data: data)
    end

    it "seasons the data before rendering the content" do
      expected = <<-EOS
<p>Mango is like a drug.<br/>
You must have more and more and more of the Mango<br/>
until there is no Mango left.<br/>
Not even for Mango!</p>
      EOS

      expect(@page.content).to eq(expected.strip)
    end
  end
end
