Fabricator(:air_import) do
  source Rails.root.join('spec/fixtures/air0.log').open('r')
  user
end
