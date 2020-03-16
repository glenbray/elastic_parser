require "parslet"

module ElasticParser
  class Parser < Parslet::Parser
    rule(:space)    { str(" ").repeat(1) }
    rule(:space?)   { space.maybe }
    rule(:quote)    { str('"') }
    rule(:lparen)   { str('(') }
    rule(:rparen)   { str(')') }

    rule(:term) do
      str("OR").absent? >> match('[^\s"()-]').repeat(1)
    end

    rule(:phrase) do
      (quote >> (term >> space?).repeat.as(:phrase) >> quote) >> space?
    end

    rule(:value) { (term.as(:term) | phrase) }

    rule(:and_op)   { ((space >> str("AND") >> space) | space?) }
    rule(:or_op)   { (space >> str("OR") >> space) }
    rule(:not_op)   { str('-') }

    rule(:group) { (lparen >> or_condition >> rparen) | value }

    rule(:not_condition) do
      (
        not_op >> value.as(:left) >> space.maybe
      ).as(:not) | group
    end

    rule(:and_condition) do
      (
        not_condition.as(:left) >> and_op >> and_condition.as(:right)
      ).as(:and) | not_condition
    end

    rule(:or_condition) do
      (
        and_condition.as(:left) >> or_op >> or_condition.as(:right)
      ).as(:or) | and_condition
    end

    rule(:query) { or_condition.as(:query) }
    root(:query)

    def self.parse(raw_query)
      new.parse(raw_query)
    rescue Parslet::ParseFailed => e
      puts e.parse_failure_cause.ascii_tree
    end
  end
end
