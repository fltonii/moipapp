class AddDataToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :cpf, :string
    add_column :users, :phoneArea, :string
    add_column :users, :phoneNumber, :string
  end
end
