require "parslet"

module ElasticParser
  class Parser < Parslet::Parser
    rule(:space)    { str(" ").repeat(1) }
    rule(:space?)   { space.maybe }
    rule(:quote) { str('"') }

    rule(:term) { match('[^\s"]').repeat(1) }

    rule(:phrase) do
      (quote >> (term >> space?).repeat.as(:phrase) >> quote) >> space?
    end

    rule(:value) { (term.as(:term) | phrase) }

    rule(:and_op)   { ((space >> str('AND') >> space) | space?) }

    rule(:and_condition) do
      (
        value.as(:left) >> and_op >> and_condition.as(:right)
      ).as(:and) | value
    end

    rule(:query) { and_condition.as(:query) }
    root(:query)

    def self.parse(raw_query)
      new.parse(raw_query)
    rescue Parslet::ParseFailed => e
      puts e.parse_failure_cause.ascii_tree
    end
  end
end
