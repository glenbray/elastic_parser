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

  describe '#and_op' do
    it 'parses AND' do
      expect(subject.and_op).to parse(' AND ')
    end

    it 'parses space when AND is not provided' do
      expect(subject.and_op).to parse(' ')
    end
  end

  describe '#and_condition' do
    it 'parses with space' do
      expect(subject.and_condition).to parse('a b')
    end

    it 'parses with AND' do
      expect(subject.and_condition).to parse('a AND b')
    end
  end

  describe '#or_op' do
    it 'parses OR' do
      expect(subject.or_op).to parse(' OR ')
    end
  end

  describe '#or_condition' do
    it 'parses with OR' do
      expect(subject.or_condition).to parse('a OR b')
    end
  end
end
