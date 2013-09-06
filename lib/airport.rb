require_relative 'plane'

class Airport
  attr_reader :capacity, :hanger, :weather

  def initialize(no_of_planes, capacity, weather)
    check_arguments(no_of_planes, capacity)
    @capacity, @weather, @bomb_scare = capacity, weather, false
    @hanger = []
    put_new_planes_in_hanger(no_of_planes)
  end

  def check_arguments(no_of_planes, capacity)
    raise ArgumentError.new(
      'Cannot have more planes than there is capacity for.'
    ) if no_of_planes > capacity
  end

  def put_new_planes_in_hanger(no_of_planes)
    no_of_planes.times { @hanger << new_plane }
  end

  def new_plane
    Plane.new(self)
  end

  def sunny_weather?
    @weather.state == :sunny
  end

  def has_space_in_hanger?
    hanger.count < capacity
  end

  def has_sunny_weather_and_no_bomb_scare?
    sunny_weather? and !has_a_bomb_scare?
  end

  def clear_to_land?
    has_space_in_hanger? and has_sunny_weather_and_no_bomb_scare?
  end

  def clear_to_take_off?
    has_sunny_weather_and_no_bomb_scare?
  end

  def land(plane)
    @hanger << plane if clear_to_land?
  end

  def take_off(plane)
    @hanger.delete(plane) if clear_to_take_off?
  end

  def has_a_bomb_scare?
    @bomb_scare
  end

  def respond_to_bomb_scare
    @bomb_scare = true
  end

  def call_off_bomb_scare
    @bomb_scare = false
  end
end