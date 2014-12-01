describe Rental::Day do
  before :all do
    @weekend = Rental::Day.new '2014-11-23', '08:00', '12:00'
    @weekday = Rental::Day.new '2014-11-24', '08:00', '12:00'
  end

  it '#hours' do
    expect(@weekend.hours).to eq 4
  end

  it '#price' do
    context 'on weekend' do
      expect(@weekend.price).to eq 7200
    end
    context 'on weekday' do
      expect(@weekday.price).to eq 6000
    end
  end

  it '#price_per_hour' do
    context 'on weekend' do
      expect(@weekend.price_per_hour).to  eq 1800.0
    end
    context 'on weekday' do
      expect(@weekday.price_per_hour).to  eq 1500.0
    end
  end
end