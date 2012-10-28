FactoryGirl.define do 

	sequence(:email) do |n|
		"artist-#{n}@soundcrowd.com"
	end

	sequence(:username) do |n|
		"artist-#{n}"
	end

	factory :user do
		username
		email
		password "cooper"
	end

	factory :production do
		title "Florida"
		after(:create) {set_creator}
	end
end

