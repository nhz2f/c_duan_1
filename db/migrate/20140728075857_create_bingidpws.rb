class CreateBingidpws < ActiveRecord::Migration
  def change
    create_table :bingidpws do |t|
      t.string :cid
      t.string :password

      t.timestamps
    end
  end
end
