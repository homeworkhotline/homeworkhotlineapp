namespace :tasks do
  desc "Delete searches everyday at midnight"
  task delete_searches: :environment do
  	Search.delete_all
  end

end
