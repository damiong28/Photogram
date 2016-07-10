FactoryGirl.define do
  factory :notification do
    user nil
    notified_by nil
    post nil
    identifier 1
    notice_type "MyString"
    read false
  end
end
