class Weather

  def state
    return :sunny if Random.rand(0..1) == 0
    :stormy
  end

end
