require "elastic_parser/version"
require "elastic_parser/parser"
require "elastic_parser/transformer"
require "elastic_parser/elastic_tree"
require "elastic_parser/nodes/elastic_node"
require "elastic_parser/nodes/leaf_node"

module ElasticParser
  class Error < StandardError; end

  FIELDS = ["title", "content"]

  # for debugging a transformed tree
  def self.transform(raw_query)
    # parse_tree = Parser.parse(raw_query)
    # Transformer.new.apply(parse_tree)
  end

  def self.parse(query)
    parse_tree = Parser.parse(query)
    elastic_tree = Transformer.new.apply(parse_tree)
    elastic_tree.to_query
  end
end
