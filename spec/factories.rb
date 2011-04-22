Factory.sequence(:objective_order) {|n| n}

Factory.define :objective do |o|
  o.name          "master TDD"
  o.description   "master TDD on Rails app"
  o.order         {Factory.next(:objective_order)}
end

