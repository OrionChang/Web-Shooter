namespace :clean_up_temp do
  desc "clean up unsaved screenshots 1 hours ago"
  task :webshots => :environment do
  	Webshot.destroy_all([ 'created_at<? AND title IS NULL', 1.days.ago ])
  end
end

