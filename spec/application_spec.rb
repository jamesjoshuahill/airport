require 'application'

describe Application do

  let(:app) { Application.new }

  it 'should have at least one airport' do
    expect(app.airports.count).to eq 1
  end

  it 'should have a given number of airports' do
    app = Application.new(3)
    expect(app.airports.count).to eq 3
  end

  it 'should have airport objects' do
    expect(app.airports.first).to be_an Airport
  end

end
