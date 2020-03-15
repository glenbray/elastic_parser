module ElasticParser::Nodes
  class NotOperatorNode < OperatorNode
    def to_query
      { bool: { must_not: left.to_query } }
    end
  end
end
