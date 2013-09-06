require 'plane'

describe Plane do
  let(:airport) { double :Airport }
  let(:plane) { Plane.new(airport) }

  it 'should start at an airport' do
    expect(plane).to be_parked_at(airport)
  end

  it 'should take off with clearance' do
    expect(airport).to receive(:clear_for_take_off?).and_return true
    plane.take_off

    expect(plane).not_to be_parked_at(airport)
    expect(plane).to be_flying
  end

  it 'should stay at airport without clearance to take off' do
    expect(airport).to receive(:clear_for_take_off?).and_return false
    plane.take_off

    expect(plane).not_to be_flying
    expect(plane).to be_parked_at(airport)
  end
  
  it 'can land at an airport with clearance' do
    expect(airport).to receive(:clear_for_take_off?).and_return true
    plane.take_off
    expect(airport).to receive(:clear_for_landing?).and_return true
    plane.land_at(airport)

    expect(plane).not_to be_flying
    expect(plane).to be_parked_at(airport)
  end

  it 'should continue flying without clearance to land' do
    expect(airport).to receive(:clear_for_take_off?).and_return true
    plane.take_off
    expect(airport).to receive(:clear_for_landing?).and_return false
    plane.land_at(airport)

    expect(plane).not_to be_parked_at(airport)
    expect(plane).to be_flying
  end

end