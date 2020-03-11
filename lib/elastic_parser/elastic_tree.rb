module ElasticParser
  class ElasticTree
    def initialize(tree)
      @root = tree
    end

    def to_query
      { query: @root.to_query }
    end
  end
end
