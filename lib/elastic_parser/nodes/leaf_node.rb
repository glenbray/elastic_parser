module ElasticParser::Nodes
  class LeafNode < ElasticNode
    def inspect
      { data: @data.inspect }
    end

    def to_query
      _key, value = @data.to_a.flatten

      {
        bool: {
          should: {
            multi_match: {
              query: value,
              fields: ElasticParser::FIELDS
            }
          },
          minimum_should_match: 1
        }
      }
    end
  end
end
