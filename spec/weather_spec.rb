require 'weather'

describe Weather do

  let(:weather) { Weather.new }
  
  context 'should at random' do

    it 'be sunny half the time' do
      expect(Random).to receive(:rand).with(0..1).and_return(0)

      expect(weather.state).to eq :sunny
    end

    it 'be stormy half the time' do
      expect(Random).to receive(:rand).with(0..1).and_return(1)

      expect(weather.state).to eq :stormy
    end

  end

end
