module ElasticParser
  class Transformer < Parslet::Transform
    rule(term: simple(:term)) do
      Nodes::LeafNode.new({ term: term.to_s.downcase })
    end

    rule(query: subtree(:query)) { ElasticTree.new(query) }
  end
end
