class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :moipid
      t.string :ccid

      t.timestamps
    end
  end
end
