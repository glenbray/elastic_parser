module ElasticParser::Nodes
  class ElasticNode
    attr_accessor :left, :right, :parent

    def initialize(data, left = nil, right = nil, parent = nil)
      @data = data
      @left = left
      @right = right
      @parent = parent
    end

    def to_query
      raise "implement me!"
    end
  end
end
