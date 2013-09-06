class Airport
  attr_reader :capacity, :hanger, :weather

  def initialize(capacity, weather)
    @capacity, @weather = capacity, weather
    @hanger = []
    @bomb_scare = false
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