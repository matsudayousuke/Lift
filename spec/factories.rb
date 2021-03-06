
Factory.define :user do |u|
  u.first_name    "松田"
  u.last_name     "洋祐"
  u.user_name     "matsudayousuke"
  u.password      "yousukematsuda"
  u.password_confirmation "yousukematsuda"
end

Factory.sequence(:objective_order) {|n| n}

Factory.define :objective do |o|
  o.name          "master TDD"
  o.description   "master TDD on Rails app"
  o.order         {Factory.next(:objective_order)}
  o.tag_list      "work, life"
  o.association   :user
end

Factory.define :result do |r|
  r.body          "今日こんな事がありましたが、うまくいきませんでした"
  r.date          Date.today
  r.association   :objective
end
