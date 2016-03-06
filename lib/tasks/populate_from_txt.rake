namespace :populate_from_txt do

  desc 'Populate from a text file with match results'

  task :liga_bbva => :environment do

    league = League.create(name: 'Liga BBVA')
    current_week = 0

    IO.readlines('./public/ligas.txt').each do |line|
      if line.include?('1ª') && !line.include?('Promoción')
        line = line.chomp.split('  ')
        line.delete('')

        year = line[0].split('-')[0].to_i
        week = line[2].lstrip.to_i
        name_team_home = line[3].lstrip
        name_team_away = line[4].lstrip
        goals = line[5].lstrip.split('-')
        goals_home = goals[0].to_i
        goals_away = goals[1].to_i

        puts line.join(' -- ') if week > 15

        unless Season.where(year: year).present?
          season = Season.create(year: year)
          season.leagues << league
        end

        lps = LeaguesPerSeason.where(league_name: 'Liga BBVA', season_year: year).first

        if week == 1
          #current_week = week
          lps.teams << (Team.where(name: name_team_home).present? ? Team.where(name: name_team_home).first : Team.create(name: name_team_home))
          lps.teams << (Team.where(name: name_team_away).present? ? Team.where(name: name_team_away).first : Team.create(name: name_team_away))
          #new_week = Week.create(round: week)
          #lps.weeks << new_week
        end

        if week != current_week
          new_week = Week.create(round: week)
          lps.weeks << new_week
          current_week = week
        else
          new_week = lps.weeks.where(round: week).first
        end

        match = Match.create(team_home_id: Team.where(name: name_team_home).first.id,
                             team_away_id: Team.where(name: name_team_away).first.id)

        new_week.matches << match

        match.goals_home = goals_home
        match.goals_away = goals_away
        match.save
      end
    end
  end
end