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

t1a = Team.create(name: 'Real Madrid', home: true)
t1b = Team.create(name: 'Real Madrid', home: false)
t2a = Team.create(name: 'Barcelona', home: true)
t2b = Team.create(name: 'Barcelona', home: false)

lps = LeaguesPerSeason.first

lps.teams << t1a
lps.teams << t1b
lps.teams << t2a
lps.teams << t2b