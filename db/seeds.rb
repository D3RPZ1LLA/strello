# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(
  email: 'kitty',
  password: 'codefu',
  password_verify: 'codefu'
)

guest = User.create(
  email: 'guest@strello.heroku.com',
  password: 'password',
  password_verify: 'password'
)

welcome_board = guest.created_boards.create(title: 'Welcome Board')

Membership.create(board_id: welcome_board.id, user_id: guest.id, admin: true)

# first_catagory = first_board.catagories.create(
#   title: "first_catagory"
# )
#
# first_card = first_board.cards.create(
#   title:"first_card",
#   start_date: 1.day.ago,
#   due_date: 1.week.from_now
# )
#
# first_card.checklist_items.create(title: "Completed")
#
# kitty.cards += [first_card]
# first_card.catagories += [first_catagory]