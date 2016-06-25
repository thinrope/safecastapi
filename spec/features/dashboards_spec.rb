feature 'Dashboard', type: :feature do
  scenario 'non-login user shows root url' do
    visit '/en-US/'

    expect(page).to have_content('Query and add to the Safecast dataset with your own application')
  end

  scenario 'login user shows root url' do
    visit '/en-US/'

    expect(page).to have_content('Query and add to the Safecast dataset with your own application')
  end
end
