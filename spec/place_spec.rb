require 'plane'

describe Plane do
  let(:airport) { double :Airport }
  let(:plane) { Plane.new(airport) }

  it 'should start at an airport' do
    expect(plane).to be_parked_at(airport)
  end

  context 'when parked at an airport should' do
    it 'go to the airport\'s runway before taking off' do
      expect(airport).to receive(:move_to_runway).with(plane)
      plane.go_to_runway
    end

    it 'take off with clearance' do
      expect(airport).to receive(:move_to_runway).with(plane)
      expect(airport).to receive(:clear_for_take_off?).and_return true
      plane.take_off

      expect(plane).not_to be_parked_at(airport)
    end

    it 'not take off without clearance' do
      expect(airport).to receive(:move_to_runway).with(plane)
      expect(airport).to receive(:clear_for_take_off?).and_return false
      plane.take_off

      expect(plane).to be_parked_at(airport)
    end
  end
  
  context 'when flying should' do
    let(:plane) { Plane.new(nil) }

    it 'land at an airport with clearance' do
      expect(airport).to receive(:clear_for_landing?).and_return true
      plane.land_at(airport)

      expect(plane).to be_parked_at(airport)
    end

    it 'not land without clearance' do
      expect(airport).to receive(:clear_for_landing?).and_return false
      plane.land_at(airport)

      expect(plane).not_to be_parked_at(airport)
    end
  end

end