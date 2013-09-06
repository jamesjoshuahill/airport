require 'weather'

describe Weather do
  
  it 'should be sunny half the time' do
    weather = Weather.new
    expect(Random).to receive(:rand).with(0..1).and_return(0)

    expect(weather.state).to eq :sunny
  end

  it 'should be stormy half the time' do
    weather = Weather.new
    expect(Random).to receive(:rand).with(0..1).and_return(1)

    expect(weather.state).to eq :stormy
  end

end