class Tags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :tag_text

      t.timestamps
    end
  end
end
