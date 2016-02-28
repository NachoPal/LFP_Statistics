# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160227183132) do

  create_table "leagues", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "leagues_per_seasons", force: :cascade do |t|
    t.integer "league_id",   limit: 4
    t.integer "season_id",   limit: 4
    t.string  "league_name", limit: 255
    t.integer "season_year", limit: 4
  end

  add_index "leagues_per_seasons", ["league_id"], name: "index_leagues_per_seasons_on_league_id", using: :btree
  add_index "leagues_per_seasons", ["season_id"], name: "index_leagues_per_seasons_on_season_id", using: :btree

  create_table "matches", force: :cascade do |t|
    t.integer "week_id",                limit: 4
    t.integer "team_home_id",           limit: 4
    t.integer "team_away_id",           limit: 4
    t.integer "goals_home",             limit: 4
    t.integer "goals_away",             limit: 4
    t.integer "possession_home",        limit: 4
    t.integer "possession_away",        limit: 4
    t.integer "shoot_home",             limit: 4
    t.integer "shoot_away",             limit: 4
    t.integer "shoot_at_goal_home",     limit: 4
    t.integer "shoot_at_goal_away",     limit: 4
    t.integer "goalposts_home",         limit: 4
    t.integer "goalposts_away",         limit: 4
    t.integer "yellow_cards_home",      limit: 4
    t.integer "yellow_cards_away",      limit: 4
    t.integer "red_cards_home",         limit: 4
    t.integer "red_cards_away",         limit: 4
    t.integer "fouls_done_home",        limit: 4
    t.integer "fouls_done_away",        limit: 4
    t.integer "fouls_received_home",    limit: 4
    t.integer "fouls_received_away",    limit: 4
    t.integer "lost_balls_home",        limit: 4
    t.integer "lost_balls_away",        limit: 4
    t.integer "recovered_balls_home",   limit: 4
    t.integer "recovered_balls_away",   limit: 4
    t.integer "offside_home",           limit: 4
    t.integer "offside_away",           limit: 4
    t.integer "penalty_home",           limit: 4
    t.integer "penalty_away",           limit: 4
    t.integer "goalkeeper_action_home", limit: 4
    t.integer "goalkeeper_action_away", limit: 4
  end

  add_index "matches", ["week_id"], name: "index_matches_on_week_id", using: :btree

  create_table "seasons", force: :cascade do |t|
    t.integer "year", limit: 4
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "teams_per_leagues_and_seasons", force: :cascade do |t|
    t.integer "leagues_per_season_id", limit: 4
    t.integer "team_id",               limit: 4
  end

  add_index "teams_per_leagues_and_seasons", ["leagues_per_season_id"], name: "index_teams_per_leagues_and_seasons_on_leagues_per_season_id", using: :btree
  add_index "teams_per_leagues_and_seasons", ["team_id"], name: "index_teams_per_leagues_and_seasons_on_team_id", using: :btree

  create_table "weeks", force: :cascade do |t|
    t.integer "round",                 limit: 4
    t.integer "leagues_per_season_id", limit: 4
  end

  add_index "weeks", ["leagues_per_season_id"], name: "index_weeks_on_leagues_per_season_id", using: :btree

end
