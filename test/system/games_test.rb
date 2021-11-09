require 'application_system_test_case'

class GamesTest < ApplicationSystemTestCase
  test 'Going to /new gives us a new random grid to play with' do
    visit new_url
    assert test: 'New game'
    assert_selector 'li', count: 10
  end

  test 'Confirm word is in grid' do
    visit new_url
    fill_in 'word', with: 'HGJHG'
    click_on 'Play'
  end

  test 'Confirm it is not a one-letter consonant word' do
    visit new_url
    fill_in 'word', with: Array('A'..'Z').sample
    click_on 'Play'
  end

  test 'Confirm it is a valid english word' do
    visit new_url
    fill_in 'word', with: Array('A'..'Z').sample
    click_on 'Play'
  end
end
