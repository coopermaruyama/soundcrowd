FactoryGirl.define do 

  factory :track do
    versions
    title       "A City in Florida"
    tags        "house, dubstep, progressive"
    bpm         120
    versions    43
    followers   197
  end
  
  factory :user do
    track
    username   "deadmau5"
    program_id    1
    sequence(:email) {|n| "deadmau#{n}@email.com" }
    password  "dm54life"
  end
  
  factory :comment do
    comment         "My cat just died - good shit"
    timestamp       Time.now
    reply_of        3
    track_timestamp 154
  end
  
  factory :follows do
    followed_id 1
    follower_id 2
  end
  
  factory :tag_relation do
    tag_id        1
    tagged_track  1
  end
  
  factory :tag do
    title "House"
  end
  
  factory :versions do
    votes         27
    forks         2
    original      true
    forked_from   0
    vsts          "massive, apmlitube"
  end
  
  factory :vst do
    name    "Massive"
    source  "http://google.com/"
  end
  
  factory :program do
    name "Ableton Live"
  end
end

