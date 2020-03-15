require "elastic_parser/version"
require "elastic_parser/parser"
require "elastic_parser/transformer"
require "elastic_parser/elastic_tree"
require "elastic_parser/nodes/elastic_node"
require "elastic_parser/nodes/leaf_node"
require "elastic_parser/nodes/operator_node"
require "elastic_parser/nodes/not_operator_node"

module ElasticParser
  class Error < StandardError; end

  FIELDS = ["title", "content"]

  # for debugging a transformed tree
  def self.transform(query)
    parse_tree = Parser.parse(query)
    Transformer.new.apply(parse_tree)
  end

  def self.parse(query)
    parse_tree = Parser.parse(query)
    elastic_tree = Transformer.new.apply(parse_tree)
    elastic_tree.to_query
  end
end
