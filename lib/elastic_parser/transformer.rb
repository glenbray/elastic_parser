module ElasticParser
  class Transformer < Parslet::Transform
    rule(term: simple(:term)) do
      Nodes::LeafNode.new(term: term.to_s.downcase)
    end

    rule(phrase: simple(:phrase)) do
      Nodes::LeafNode.new(phrase: phrase.to_s.downcase)
    end

    rule(and: { left: subtree(:left), right: subtree(:right) }) do
      node = Nodes::OperatorNode.new(:and, left, right)
      left.parent = node if left
      right.parent = node if right
    end

    rule(or: { left: subtree(:left), right: subtree(:right) }) do
      node = Nodes::OperatorNode.new(:or, left, right)
      left.parent = node if left
      right.parent = node if right
    end

    rule(query: subtree(:query)) { ElasticTree.new(query) }
  end
end
