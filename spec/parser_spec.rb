require 'parslet/rig/rspec'

RSpec.describe ElasticParser::Parser do
  subject { ElasticParser::Parser.new }

  describe "term" do
    it "parses term" do
      expect(subject.term).to parse("a")
    end
  end
end
