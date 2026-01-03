class AddUiModeToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :ui_mode, :string, null: false, default: "hotwire"
    add_index :users, :ui_mode
  end
end
