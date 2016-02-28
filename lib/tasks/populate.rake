namespace :populate do

  desc 'populate Liga BBVA'

  task :liga_bbva => :environment do

    s1 = Season.create(year: 2015)
    l1 = League.create(name: 'Liga BBVA')
    s1.leagues << l1

    lps = LeaguesPerSeason.where(league_name: 'Liga BBVA', season_year: 2015).first

    agent = Mechanize.new

    scrap_week_page(25,2,lps,agent)
  end

  #==================================================================================

  def scrap_week_page(last_week, init_week, lps,agent)
    weeks = (init_week..last_week).to_a

    weeks.each do |week|
      new_week = Week.create(round: week)
      lps.weeks << new_week

      week_page = agent.get("http://resultados.as.com/resultados/futbol/primera/2015_2016/jornada/regular_a_#{week}")
      root_nodes = week_page.search("tr[@itemtype='http://schema.org/SportsEvent']")

      root_nodes.each do |node|
        name_team_home = node.search("span[@itemprop='name']").first.text.lstrip.chomp
        name_team_away = node.search("span[@itemprop='name']")[1].text.lstrip.chomp

        if week == init_week
          lps.teams << Team.create(name: name_team_home)
          lps.teams << Team.create(name: name_team_away)
        end

        match_link = node.search("td","a[@class='resultado']")[1].children.first.attributes["href"].value

        scrap_match_page(match_link, name_team_home, name_team_away, new_week, agent)
      end
    end
  end

  def scrap_match_page(link, name_team_home, name_team_away, new_week, agent)
    match = Match.create(team_home_id: Team.where(name: name_team_home).first.id,
                         team_away_id: Team.where(name: name_team_away).first.id)
    new_week.matches << match

    match_page = agent.get(link + '/estadisticas/')

    puts link + '/estadisticas/'

    if match_page.search('span.tanteo-local').blank?
      puts "Error for the week: #{new_week.round}, in the match: #{name_team_home} - #{name_team_away}"
      return
    end

    match.goals_home = match_page.search('span.tanteo-local').text.chomp.to_i
    match.goals_away = match_page.search('span.tanteo-visit').text.chomp.to_i

    match.possession_home = match_page.search('span.porcentaje-posesion').first.text.chomp.gsub('%','').to_i
    match.possession_away = match_page.search('span.porcentaje-posesion').last.text.chomp.gsub('%','').to_i

    match.shoot_at_goal_home = match_page.search('div.cont-datos-remates.apuerta').search('span.datos-remates-local').text.to_i
    match.shoot_at_goal_away = match_page.search('div.cont-datos-remates.apuerta').search('span.datos-remates-visitante').text.to_i

    match.shoot_home = match_page.search('div.cont-datos-remates.fuera').search('span.datos-remates-local').text.to_i
    match.shoot_away = match_page.search('div.cont-datos-remates.fuera').search('span.datos-remates-visitante').text.to_i

    match.goalposts_home = match_page.search('div.cont-datos-remates.poste').search('span.datos-remates-local').text.to_i
    match.goalposts_away = match_page.search('div.cont-datos-remates.poste').search('span.datos-remates-visitante').text.to_i

    match_page.search('div.cont-estadistica.cf').search('li').each_with_index do |field,i|

      case i
        when 0
          match.yellow_cards_home = field.search('span.valor-estadistico').first.text.to_i
          match.yellow_cards_away = field.search('span.valor-estadistico').last.text.to_i
        when 1
          match.red_cards_home = field.search('span.valor-estadistico').first.text.to_i
          match.red_cards_away = field.search('span.valor-estadistico').last.text.to_i
        when 2
          match.fouls_received_home = field.search('span.valor-estadistico').first.text.to_i
          match.fouls_received_away = field.search('span.valor-estadistico').last.text.to_i
        when 3
          match.fouls_done_home = field.search('span.valor-estadistico').first.text.to_i
          match.fouls_done_away = field.search('span.valor-estadistico').last.text.to_i
        when 4
          match.lost_balls_home = field.search('span.valor-estadistico').first.text.to_i
          match.lost_balls_away = field.search('span.valor-estadistico').last.text.to_i
        when 5
          match.recovered_balls_home = field.search('span.valor-estadistico').first.text.to_i
          match.recovered_balls_away = field.search('span.valor-estadistico').last.text.to_i
        when 6
          match.offside_home = field.search('span.valor-estadistico').first.text.to_i
          match.offside_away = field.search('span.valor-estadistico').last.text.to_i
        when 7
          match.penalty_home = field.search('span.valor-estadistico').first.text.to_i
          match.penalty_away = field.search('span.valor-estadistico').last.text.to_i
        when 8
          match.goalkeeper_action_home = field.search('span.valor-estadistico').first.text.to_i
          match.goalkeeper_action_away = field.search('span.valor-estadistico').last.text.to_i
      end
    end

    match.save
  end
end
