require 'rails_helper'

RSpec.describe PagesHelper, :type => :helper do
  describe "#pretty_print" do
    def examples 
      [
        {arguments: {one: "here", two: "here as well"}, 
          result: "<ul><li>one : here</li><li>two : here as well</li></ul>"},
        {arguments: [{one: "here"}, {two: "here as well"}],
          result: "<div><ul><li>one : here</li></ul></div><div><ul><li>two : here as well</li></ul></div>"},
        {arguments: [{one: "here", two: {inside: "here as well"}}],
          result: "<div><ul><li>one : here</li><li>two</li><ul><li>inside : here as well</li></ul></ul></div>"}
      ]
    end
    
    it "display correctly the examples" do
      examples.each do |example|
        expect(helper.pretty_print(example[:arguments])).to eq example[:result]
      end
    end
  end
end
