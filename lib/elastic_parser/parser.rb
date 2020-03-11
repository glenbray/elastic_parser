require "parslet"

module ElasticParser
  class Parser < Parslet::Parser
    rule(:term) { match('.').repeat(1).as(:term) }

    rule(:query) { term.as(:query) }
    root(:query)

    def self.parse(raw_query)
      new.parse(raw_query)
    rescue Parslet::ParseFailed => e
      puts e.parse_failure_cause.ascii_tree
    end
  end
end
