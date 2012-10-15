# This file should contain all the record creation needed to seed the database with its default values.

# create users
User.create(:email => "cooperm@susteen.com", :password => "cooper", :username => "cmoney")
5.times do |t|
	user = User.create(:email => Faker::Internet.email, :password => "password", :username => Faker::Internet.user_name)
	2.times do |p|
		production = user.productions.create!(:creator_id => user.id)
		# get songs
		d = Dir.new("public/audio")
		songs = d.entries.find_all {|file| file =~ /m4a/}
		original = production.versions.build(:user_id => user.id)
		original.audio_file = File.open("public/audio/"+songs[rand(songs.length)])#select random song in audio folder
		original.save!
	end
	20.times do |r|
		#find random song
		d = Dir.new("public/audio")
		songs = d.entries.find_all {|file| file =~ /m4a/}
		
		user = User.random
		version = Version.random
		remix = version.children.build(:user_id => user.id, :production_id => version.production_id)
		remix.audio_file = File.open("public/audio/"+songs[rand(songs.length)])#select random song in audio folder
		remix.save!
	end
end
