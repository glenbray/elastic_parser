RSpec.describe ElasticParser do
  describe ".parse" do
    subject { ElasticParser.parse(query) }

    context "simple query" do
      let(:query) { "word" }

      it "simple query" do
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
  end
end
