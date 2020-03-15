module ElasticParser::Nodes
  class OperatorNode < ElasticNode
    def to_elastic_op(data)
      case data
      when :and
        :must
      when :or
        :should
      else
        raise "Unknown operator: #{operator}"
      end
    end

    def inspect
      { data: @data, left: @left.inspect, right: @right.inspect }
    end

    def operator
      to_elastic_op(@data)
    end

    def to_query
      { bool: { operator => [left.to_query, right.to_query].flatten } }
    end
  end
end
