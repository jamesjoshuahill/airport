require 'airport'

describe Airport do
  let(:weather) { double :Weather }
  let(:airport) { Airport.new(0, 10, weather) }
  let(:plane) { double :Plane }
  
  it 'should have it\'s own weather' do
    expect(airport.weather).to eq weather
  end

  it 'should start without a bomb scare' do
    expect(airport).not_to have_a_bomb_scare
  end

  context 'can have bomb scare which should' do
    before(:each) { airport.respond_to_bomb_scare }
    it 'be responded to' do
      expect(airport).to have_a_bomb_scare
    end

    it 'be called off' do
      airport.call_off_bomb_scare
      expect(airport).not_to have_a_bomb_scare
    end
  end

  context 'should have a hanger' do
    it 'with a maximum capacity' do
      expect(airport.capacity).to eq 10
    end

    it 'with a given number of planes' do
      airport = Airport.new(1, 10, weather)
      expect(airport.hanger.count).to eq 1
    end

    it 'but cannot have more planes than there is capacity for' do
      expect {
        airport = Airport.new(10, 5, weather)
      }.to raise_error(ArgumentError,
        'Cannot have more planes than there is capacity for.')
    end
  end

  context 'should have a runway' do
    it 'that starts empty' do
      expect(airport.runway).to be_nil
    end

    it 'that cannot have more than one plane' do
      plane2 = double :Plane
      airport.move_to_runway(plane)
      airport.move_to_runway(plane2)

      expect(airport.runway).to eq plane
    end

    it 'that a plane can be moved to from the hanger' do
      expect(airport).to receive(:clear_to_land?).and_return true
      airport.land(plane)
      airport.move_to_runway(plane)

      expect(airport.hanger).not_to include plane
      expect(airport.runway).to eq plane
    end
  end

  context 'should let planes land' do
    it 'if there space in the hanger, sunny weather and no bomb scare' do
      expect(weather).to receive(:state).and_return :sunny
      expect(airport).to be_clear_to_land
    end

    it 'and put them in the hanger' do
      expect(airport).to receive(:clear_to_land?).and_return true
      airport.land(plane)

      expect(airport.hanger).to include plane
    end
  end

  context 'should not land planes if there is' do
    it 'stormy weather' do
      expect(weather).to receive(:state).and_return :stormy
      expect(airport).not_to be_clear_to_land
    end

    it 'no space in the hanger' do
      airport = Airport.new(50, 50, weather)
      expect(airport).not_to be_clear_to_land
    end

    it 'a bomb scare' do
      expect(weather).to receive(:state).and_return :sunny
      airport.respond_to_bomb_scare

      expect(airport).not_to be_clear_to_land
    end
  end

  context 'should let planes take off' do
    it 'if there is sunny weather and no bomb scare' do
      expect(weather).to receive(:state).and_return :sunny
      expect(airport).to be_clear_to_take_off
    end

    it 'and remove them from the hanger' do
      expect(airport).to receive(:clear_to_land?).and_return true
      airport.land(plane)
      expect(airport).to receive(:clear_to_take_off?).and_return true
      airport.take_off(plane)
 
      expect(airport.hanger).not_to include plane
    end

    xit 'from the runway and remove them from the airport' do
      expect(airport).to receive(:clear_to_land?).and_return true
      airport.land(plane)
      expect(airport).to receive(:move_to_runway).with(plane)
      expect(airport).to receive(:clear_to_take_off?).and_return true
      airport.take_off(plane)

      expect(airport.hanger).not_to include plane
      expect(airport.runway).to eq nil
    end
  end

  context 'should not let planes take off if there is' do
    it 'stormy weather' do
      expect(weather).to receive(:state).and_return :stormy
      expect(airport).not_to be_clear_to_take_off
    end

    it 'a bomb scare' do
      expect(weather).to receive(:state).and_return :sunny
      airport.respond_to_bomb_scare

      expect(airport).not_to be_clear_to_take_off
    end
  end
end