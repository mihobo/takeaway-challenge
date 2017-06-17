class Menu
  attr_reader :dishes

  def initialize
    dishes
  end

  def dishes
    @dishes = { 'Kobe Slider' => 7,
                'Shrimp Tempura'=> 4,
                'Salmon Teriyaki' => 5,
                'Chicken Katsu' => 8,
                'Edamame' => 2 }
  end

  def read_menu
    @dishes.each do |key , value|
      puts key + ": £" + value.to_s
    end
  end

end