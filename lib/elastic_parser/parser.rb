require "parslet"

module ElasticParser
  class Parser < Parslet::Parser
    rule(:space)    { match('\s').repeat(1) }
    rule(:space?)   { space.maybe }

    rule(:term) { match('[^\s"]').repeat(1) }

    rule(:quote) { str('"') }

    rule(:phrase) do
      (quote >> (term >> space?).repeat.as(:phrase) >> quote) >> space?
    end

    rule(:value) { (term.as(:term) | phrase) }

    rule(:query) { value.as(:query) }
    root(:query)

    def self.parse(raw_query)
      new.parse(raw_query)
    rescue Parslet::ParseFailed => e
      puts e.parse_failure_cause.ascii_tree
    end
  end
end
