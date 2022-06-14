class CreateCourts < ActiveRecord::Migration[7.0]
  def change
    create_table :courts do |t|
      t.string :name
      t.string :code
      t.string :type

      t.timestamps
    end
  end
end
