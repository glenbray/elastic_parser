RSpec.describe ElasticParser do
  describe ".parse" do
    subject { ElasticParser.parse(query) }

    context "simple query" do
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

    context "phrase search" do
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

    context "AND query" do
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
  end
end
