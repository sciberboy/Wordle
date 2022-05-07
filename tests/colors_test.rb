require_relative './../config/config'
require 'minitest/autorun'
require 'colors'

class Colors_test < Minitest::Test

  def test_G_Y_B_G_Y
    colors = [
      ' '.on_green,
      ' '.on_yellow,
      ' '.on_black,
      ' '.on_green,
      ' '.on_yellow
    ]
    assert_equal  colors, Colors.add_color(%w[G Y B G Y])
  end
end
