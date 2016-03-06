module Goals

  def self.stats_for_match(season, league, week, team_name_home, team_name_away)
    lps = LeaguesPerSeason.where(season_year: season, league_name: league).last

    team_goals_home_home = lps.matches.team_home(team_name_home).joins(:week).where('weeks.round < ?', week).map(&:goals_home)
    team_goals_home_away = lps.matches.team_home(team_name_home).joins(:week).where('weeks.round < ?', week).map(&:goals_away)
    team_goals_away_away = lps.matches.team_away(team_name_away).joins(:week).where('weeks.round < ?', week).map(&:goals_away)
    team_goals_away_home = lps.matches.team_away(team_name_away).joins(:week).where('weeks.round < ?', week).map(&:goals_home)

    team_goals_home = team_goals_home_home.map.with_index{ |m,i| m + team_goals_home_away[i].to_i }
    team_goals_away = team_goals_away_away.map.with_index{ |m,i| m + team_goals_away_home[i].to_i }

    team_goals_home = generate_hash_by_total_goals(team_goals_home)
    team_goals_away = generate_hash_by_total_goals(team_goals_away)
    
    num_matches_home = team_goals_home.values.sum
    num_matches_away = team_goals_away.values.sum

    result_home = {}
    result_away = {}

    [team_goals_home, team_goals_away].each_with_index do |team_goals, i|
      more_results = {0.5 => 0, 1.5 => 0, 2.5 => 0, 3.5 => 0, 4.5 => 0}
      less_results = {0.5 => 0, 1.5 => 0, 2.5 => 0, 3.5 => 0, 4.5 => 0}

      team_goals.each do |k,v|
        if k == 0
          less_results[0.5]+= v
          less_results[1.5]+= v
          less_results[2.5]+= v
          less_results[3.5]+= v
          less_results[4.5]+= v
        elsif k == 1
          more_results[0.5]+= v
          less_results[1.5]+= v
          less_results[2.5]+= v
          less_results[3.5]+= v
          less_results[4.5]+= v
        elsif k == 2
          more_results[0.5]+= v
          more_results[1.5]+= v
          less_results[2.5]+= v
          less_results[3.5]+= v
          less_results[4.5]+= v
        elsif k == 3
          more_results[0.5]+= v
          more_results[1.5]+= v
          more_results[2.5]+= v
          less_results[3.5]+= v
          less_results[4.5]+= v
        elsif k == 4
          more_results[0.5]+= v
          more_results[1.5]+= v
          more_results[2.5]+= v
          more_results[3.5]+= v
          less_results[4.5]+= v
        elsif k == 5 || k > 5
          more_results[0.5]+= v
          more_results[1.5]+= v
          more_results[2.5]+= v
          more_results[3.5]+= v
          more_results[4.5]+= v
        end
      end

      num_matches = (i==0) ? num_matches_home : num_matches_away

      more_results.each do |k,v|
        more_results[k] = (v.to_f/num_matches*100).round(2)
      end

      less_results.each do |k,v|
        less_results[k] = (v.to_f/num_matches*100).round(2)
      end

      result_home = {more: more_results, less: less_results} if i == 0
      result_away = {more: more_results, less: less_results} if i == 1
    end

    {home: result_home, away: result_away}
  end

  private

  def Goals.generate_hash_by_total_goals(team_goals)
    team_goals_hash = {}

    team_goals.each do |goals|
      team_goals_hash[goals] ||= 0
      team_goals_hash[goals] += 1
    end
    team_goals_hash
  end

end