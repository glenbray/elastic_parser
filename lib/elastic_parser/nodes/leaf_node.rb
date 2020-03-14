module ElasticParser::Nodes
  class LeafNode < ElasticNode
    def inspect
      { data: @data.inspect }
    end

    def to_query
      key, value = @data.to_a.flatten

      case key
      when :term
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
      when :phrase
        {
          bool: {
            minimum_should_match: 1,
            :should => ElasticParser::FIELDS.map do |field|
              { match_phrase: { field => value } }
            end
          }
        }
      end
    end
  end
end
