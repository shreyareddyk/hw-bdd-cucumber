# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(title: movie[:title], rating: movie[:rating], release_date: movie[:release_date])

  end
  #fail "Unimplemented"
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2| #tests to sort
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  regular_exp = /#{e1}.*{e2}/m
  regular_exp.match(page.body)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  if uncheck == "un"
    rating_list.split(', ').each { |x| step %{I uncheck "ratings_#{x}"} }
  else
    rating_list.split(', ').each { |x| step %{I check "ratings_#{x}"} }
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  rows = page.all('table#movies tbody tr').length
  expect(rows).to eq Movie.count
  # fail "Unimplemented"
end

Then /I should see the movies : (.*)/ do |movie_list| #tests for filtering
  # pending # Write code here that turns the phrase above into concrete actions
  movies = movie_list.split(', ')
  for movie in movies
      step "I should see " + movie
  end
end

Then /I should not see the movies : (.*)/ do |movie_list| #tests for filtering
  # pending # Write code here that turns the phrase above into concrete actions
  movies = movie_list.split(', ')
  for movie in movies
      step "I should not see " + movie
  end
end
