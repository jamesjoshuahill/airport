class Plane

  def initialize(airport)
    @airport = airport
  end

  def parked_at?(airport)
    @airport == airport
  end

  def land_at(airport)
    @airport = airport if airport.clear_for_landing?
  end

  def take_off
    go_to_runway
    @airport = nil if @airport.clear_for_take_off?
  end

  def go_to_runway
    @airport.move_to_runway(self)
  end

end
