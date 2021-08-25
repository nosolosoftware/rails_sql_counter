RSpec.describe RailsSqlCounter do
  let(:num_queries) { rand(1..10) }

  it 'has a version number' do
    expect(described_class::VERSION).not_to be_nil
  end

  describe '.profile' do
    it 'counts correctly query' do
      simulate_query

      described_class.profile do
        num_queries.times { simulate_query }
      end

      simulate_query

      expect(described_class.counter).to eq(num_queries)
    end

    it 'resets counter for each time' do
      described_class.profile do
        num_queries.times { simulate_query }
      end
      expect(described_class.counter).to eq(num_queries)

      described_class.profile { simulate_query }
      expect(described_class.counter).to eq(1)
    end
  end

  describe '.start / .end' do
    it 'counts correctly query' do
      simulate_query

      described_class.start
      num_queries.times { simulate_query }
      described_class.end

      simulate_query

      expect(described_class.counter).to eq(num_queries)
    end

    it 'resets counter for each time' do
      described_class.start
      num_queries.times { simulate_query }
      described_class.end
      expect(described_class.counter).to eq(num_queries)

      described_class.start
      simulate_query
      described_class.end
      expect(described_class.counter).to eq(1)
    end
  end
end
