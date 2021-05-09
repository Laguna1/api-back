# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# rubocop:disable Layout/LineLength
User.destroy_all
Activity.destroy.all
Tracking.destroy.all

u1 = User.create(username: 'Oksana', password: '11111111')
u2 = User.create(username: 'Laura', password: '22222222')

a1 = Activity.create(user_id: 1, name: 'Running', place: 'Central Park', intensity: 'middle')
a2 = Activity.create(user_id: 1, name: 'Fitness', place: 'Vostorg Gym', intensity: 'high')

tr1 = Tracking.create(activity_id: 1, date: '2021-05-10', pulse: 60, duration: 45, distance: 3000, calories: 120, rate: 'well')
tr2 = Tracking.create(activity_id: 1, date: '2021-05-12', pulse: 70, duration: 60, distance: '', calories: 90, rate: 'so-so')

# rubocop:enable Layout/LineLength