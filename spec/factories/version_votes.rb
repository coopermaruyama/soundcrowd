# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :version_vote do
    user__id 1
    version_id 1
  end
end
