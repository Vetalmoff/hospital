class AddImgToDoctors < ActiveRecord::Migration[6.0]
  def change
    add_column :doctors, :img, :string
  end
end
