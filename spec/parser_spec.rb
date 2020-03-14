require 'parslet/rig/rspec'

RSpec.describe ElasticParser::Parser do
  subject { ElasticParser::Parser.new }

  describe "#space" do
    it "parses space" do
      expect(subject.space).to parse(" ")
    end
  end

  describe "#space?" do
    it "parses empty string" do
      expect(subject.space?).to parse("")
    end

    it "parses space" do
      expect(subject.space?).to parse(" ")
    end
  end

  describe '#quote' do
    it 'parses quotes' do
      expect(subject.quote).to parse('"')
    end
  end

  describe "term" do
    it "parses term" do
      expect(subject.term).to parse("a")
    end
  end

  describe '#phrase' do
    it 'parses words wrapped in quotes' do
      expect(subject.phrase).to parse('"a b c"')
    end
  end
end
