class AddPhotoToCampingCar < ActiveRecord::Migration
  def change
    add_column :camping_cars, :photo, :string
  end
end
