require File.expand_path('../../test_helper', __FILE__)

describe ApplicationHelper do
  it "formats authors" do
    [
      [[], 'No authors specified'],
      [['Manfred'], 'Manfred'],
      [['Eloy', 'Manfred'], 'Eloy and Manfred']
    ].each do |example, expected|
      format_authors(example).should == expected
    end
  end

  it "formats markdown" do
    expected = '<p><em>Hello</em> &lt;h1>&ldquo;funky&rdquo;&lt;/h1> <strong>world</strong>!</p>'
    markdown('_Hello_ <h1>"funky"</h1> **world**!').strip.should == expected
  end
end
