class CreateCase < ActiveRecord::Migration[5.2]
  def change
    create_table :notification do |t|
      t.string :claimant
      t.string :allegation
      t.string :associate
      t.string :evidence
      t.string :lawyer

      t.timestamps
    end
  end
end

