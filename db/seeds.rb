# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Leages

l1 = League.create(name: 'Liga BBVA')
l2 = League.create(name: 'Liga Adelante')

s1 = Season.create(year: 2015)

s1.leagues << l1
s1.leagues << l2

t1 = Team.create(name: 'Real Madrid')
t2 = Team.create(name: 'Barcelona')


lps = LeaguesPerSeason.first

lps.teams << t1
lps.teams << t2


week = Week.create(round: 1)
lps.weeks << week


match1 = Match.create(team_home_id: t1.id,
                     team_away_id: t2.id)

match2 = Match.create(team_home_id: t2.id,
                      team_away_id: t1.id)

week.matches << match1
week.matches << match2