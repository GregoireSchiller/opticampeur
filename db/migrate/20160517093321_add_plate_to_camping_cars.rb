class AddPlateToCampingCars < ActiveRecord::Migration
  def change
    add_column :camping_cars, :plate, :string
  end
end
