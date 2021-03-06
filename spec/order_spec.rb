require 'order'
require 'menu'

describe Order do
  let(:order) { described_class.new }
  let(:dish) { double('Kobe Slider') }

  describe '#initialize' do
    it 'initializes the order with an empty basket' do
      expect(order.basket).to be_empty
    end
  end

  describe '#order_dish' do
    it 'orders a dish on the menu' do
      dish = 'Kobe Slider'
      menu_item = order.lookup_item(dish)
      order.order_dish(1, dish)
      expect(order.basket).to include(menu_item)
    end

    it 'changes the quantity of the item' do
      dish = 'Kobe Slider'
      menu_item = order.lookup_item(dish)
      order.order_dish(2, dish)
      expect(order.basket).to contain_exactly(menu_item, menu_item)
    end
  end

  describe '#lookup_item' do
    it 'looks up the item from the menu' do
      dish = 'Kobe Slider'
      expect(order.lookup_item(dish)).to eq('Kobe Slider' => 7)
    end

    it 'verifies if the dish exists on the menu' do
      expect(order.lookup_item('Kobe Slider')).to include('Kobe Slider')
    end

    it 'verifies the dish does not exist on the menu' do
      expect { order.lookup_item('Dragon Roll') }.to raise_error('Please enter an item from the menu.')
    end
  end

  describe '#create_basket_items' do
    it 'creates a list of items in the basket' do
      dish = 'Kobe Slider'
      order.order_dish(2, dish)
      expect(order.create_basket_items).to be == '(2) Kobe Slider(s): £14' + "\n"
    end
  end

  describe '#combine_items' do
    it 'combines and gives the quantity items' do
      dish = 'Kobe Slider'
      order.order_dish(2, dish)
      expect { order.combine_items }.to change(order, :updated_basket)
    end
  end

  describe '#create_basket_total' do
    it 'gets the subtotal of the basket' do
      dish = 'Kobe Slider'
      order.order_dish(2, dish)
      expect(order.create_basket_total).to eq 14
    end
  end

  describe '#show_basket' do
    describe '#show_items' do
      it 'shows the current items in the basket' do
        dish = 'Kobe Slider'
        order.order_dish(2, dish)
        expect { order.show_items }.to output('(2) Kobe Slider(s): £14' + "\n").to_stdout
      end
    end

    describe '#show_total' do
      it 'shows the total of the current items in the basket' do
        dish = 'Kobe Slider'
        order.order_dish(2, dish)
        expect { order.show_total }.to output('Total to pay: £14' + "\n").to_stdout
      end
    end
  end

  describe '#place_order' do
    xit 'confirms a sent text message' do
      expect { order.place_order }.to output("Sent message to customer: Miho" + "\n").to_stdout
    end
  end
end
