namespace :predict do
  desc 'Prediction of total goals by match'

  task :goals => :environment do

    match = 0
    fail = 0
    no_bet = 0
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

        if week != current_week
          puts "=================================================================================== #{week-1} -> matches - #{match} / fails - #{fail} / no_bets - #{no_bet}" if week > 15
          match = 0
          fail = 0
          no_bet = 0
          current_week = week
        end

        if week > 15
          results = Stats::Goals.stats_for_match(year, 'Liga BBVA', week, name_team_home, name_team_away)
          bet = decide_bet(results)

          if bet.keys.first == :more
            (goals_home + goals_away) > bet.values.first ? match+=1 : fail+=1
          elsif bet.keys.first == :less
            (goals_home + goals_away) < bet.values.first ? match+=1 : fail+=1
          elsif bet.keys.first == :no_bet
             no_bet+=1
          end

        end
      end
    end
  end

  def decide_bet(results)
    home_more = results[:home][:more].select { |_k,v| v > 80}
    home_less = results[:home][:less].select { |_k,v| v > 80}
    away_more = results[:home][:more].select { |_k,v| v > 80}
    away_less = results[:away][:less].select { |_k,v| v > 80}

    more = home_more.keep_if { |k, _v| away_more.key? k }
    less = home_less.keep_if { |k, _v| away_less.key? k }

    if !more.blank?
      more = [(more.sort_by {|_key, value| value}).to_h.first].to_h
    end

    if !less.blank?
      less = [(less.sort_by {|_key, value| value}).to_h.first].to_h
    end

    return {no_bet: true} if more == {} && less == {}
    more = {more: 101} if more == {}
    less = {less: 101} if less == {}

    if more.values.first <= less.values.first
      #puts more.values.first
      #more.values.first < 85 ? {more: more.keys.first} : {no_bet: true}
      {more: more.keys.first}
    elsif less.values.first < more.values.first
      #puts less.values.first
      #less.values.first < 85 ? {less: less.keys.first} : {no_bet: true}
      {less: less.keys.first}
    else
      {no_bet: true}
    end
  end
end