describe Rental::Day do
  before :all do
    @weekend = Rental::Day.new date: '2014-11-23', start_at: '08:00', end_at: '12:00'
    @weekday = Rental::Day.new date: '2014-11-24', start_at: '08:00', end_at: '12:00'
  end

  it '#hours' do
    expect(@weekend.hours).to eq 4
  end

  context 'on weekend' do
    it '#price' do
      expect(@weekend.price).to eq 7200
    end
    it '#price_per_hour' do
      expect(@weekend.price_per_hour).to  eq 1800.0
    end
  end

  context 'on weekday' do
    it '#price' do
      expect(@weekday.price).to eq 6000
    end

    it '#price_per_hour' do
      expect(@weekday.price_per_hour).to  eq 1500.0
    end
  end
end