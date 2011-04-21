Factory.sequence :objective_seq do |n|
  n
end

Factory.define :objective do |o|
  o.name          "master TDD"
  o.description   "master TDD on Rails app"
  o.order         Factory.next(:objective_seq)
end

