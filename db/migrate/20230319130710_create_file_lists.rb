class CreateFileLists < ActiveRecord::Migration[7.0]
  def change
    create_table :file_lists do |t|
      t.boolean :private
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
