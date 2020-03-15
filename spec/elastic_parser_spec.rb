RSpec.describe ElasticParser do
  describe ".parse" do
    subject { ElasticParser.parse(query) }

    describe "simple query" do
      let(:query) { "word" }

      it "returns multi match query" do
        expected = {
          :query => {
            :bool => {
              :minimum_should_match => 1,
              :should => {
                :multi_match => {
                  :fields => ElasticParser::FIELDS,
                  :query => query
                }
              }
            }
          }
        }

        expect(subject).to eq(expected)
      end
    end

    describe "phrase search" do
      let(:query) { '"this is a phrase"' }

      it "returns match phrase query" do
        expected = {
          :query => {
            :bool => {
              :minimum_should_match => 1,
              :should => ElasticParser::FIELDS.map do |field|
                { match_phrase: { field => "this is a phrase" } }
              end
            }
          }
        }

        expect(subject).to eq(expected)
      end
    end

    describe "AND query" do
      let(:search_terms) { ['supplier', 'dog'] }

      let(:expected) do
        {
          :query => {
            :bool => {
              :must => search_terms.map do |word|
                {
                  :bool => {
                    :minimum_should_match => 1,
                    :should => {
                      :multi_match => {
                        :fields => ElasticParser::FIELDS,
                        :query => word
                      }
                    }
                  }
                }
              end
            }
          }
        }
      end

      context "with space" do
        let(:query) { "supplier dog" }

        it "returns match phrase query" do
          expect(subject).to eq(expected)
        end
      end

      context "with AND operator" do
        let(:query) { "supplier AND dog"}

        it "returns match phrase query" do
          expect(subject).to eq(expected)
        end
      end
    end

    describe "OR query" do
      let(:search_terms) { ['supplier', 'dog'] }

      let(:expected) do
        {
          :query => {
            :bool => {
              :should => search_terms.map do |word|
                {
                  :bool => {
                    :minimum_should_match => 1,
                    :should => {
                      :multi_match => {
                        :fields => ElasticParser::FIELDS,
                        :query => word
                      }
                    }
                  }
                }
              end
            }
          }
        }
      end

      context "with OR operator" do
        let(:query) { "supplier OR dog"}

        it "returns match phrase query" do
          expect(subject).to eq(expected)
        end
      end
    end

    describe "NOT query" do
      let(:query) { "-dog"}

      let(:expected) do
        {
          :query => {
            :bool => {
              :must_not => {
                :bool => {
                  :minimum_should_match => 1,
                  :should => {
                    :multi_match => {
                      :fields => ElasticParser::FIELDS,
                      :query => 'dog'
                    }
                  }
                }
              }
            }
          }
        }
      end

      context "with NOT operator" do
        it "returns match phrase query" do
          expect(subject).to eq(expected)
        end
      end
    end
  end
end
