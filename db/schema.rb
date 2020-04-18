
ActiveRecord::Schema.define(version: 2020_01_05_131201) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "mysql"

  create_table "case", force: :cascade do |t|
    t.string "claimant"
    t.string "allegation"
    t.string "associate"
    t.string "evidence"
    t.string "lawyer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
