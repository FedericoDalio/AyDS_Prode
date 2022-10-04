# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_220_920_135_814) do
  create_table 'forecasts', force: :cascade do |t|
    t.integer 'user_id'
    t.integer 'match_id'
    t.integer 'local'
    t.integer 'visitor'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'score'
    t.index ['match_id'], name: 'index_forecasts_on_match_id'
    t.index ['user_id'], name: 'index_forecasts_on_user_id'
  end

  create_table 'matches', force: :cascade do |t|
    t.integer 'local_id'
    t.integer 'visitor_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'date'
    t.index ['local_id'], name: 'index_matches_on_local_id'
    t.index ['visitor_id'], name: 'index_matches_on_visitor_id'
  end

  create_table 'results', force: :cascade do |t|
    t.integer 'match_id'
    t.integer 'local'
    t.integer 'visitor'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['match_id'], name: 'index_results_on_match_id'
  end

  create_table 'teams', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.string 'city'
    t.text 'trophies'
    t.text 'linkContent'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.string 'password'
    t.string 'password_digest'
    t.integer 'total_score'
  end

  add_foreign_key 'matches', 'teams', column: 'local_id'
  add_foreign_key 'matches', 'teams', column: 'visitor_id'
end
