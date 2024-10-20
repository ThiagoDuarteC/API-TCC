class AddBankNameToAccounts < ActiveRecord::Migration[7.2]
  def change
    add_column :accounts, :bank_name, :string, :null => false
  end
end
