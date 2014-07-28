class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.string :query
      t.string :title
      t.string :description
      t.string :displayurl
      t.string :url

      t.timestamps
    end
  end
end
