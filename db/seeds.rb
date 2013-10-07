# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
kitty = User.create(
  email: 'kitty',
  password: 'codefu',
  password_verify: 'codefu'
)
first_board = kitty.created_boards.create(title: 'first_board')

Membership.create(board_id: first_board.id, user_id: kitty.id, admin: true)

first_catagory = first_board.catagories.create(
  title: "first_catagory"
)

first_card = first_board.cards.create(
  title:"first_card",
  start_date: Time.now,
  due_date: 1.week.from_now
)

kitty.cards += [first_card]
first_card.catagories += [first_catagory]