# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :version do
    forked_from 1
    source_file "MyString"
    audio_file "MyString"
    production_id 1
  end
end
