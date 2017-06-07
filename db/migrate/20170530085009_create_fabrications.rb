class CreateFabrications < ActiveRecord::Migration
  def change
    create_table :fabrications do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
