#create some seed data to work with

#create 2 Users

david = User.create(name: "david", user_name: "takcyn", password: "password")
user2 = User.create(name: "user2", user_name: "user2", password: "password")

# Create some journal response_entries

ResponseEntry.create(content: "There is no information", user_id: david.id)

# Use AR to pre-associate data

david.response_entries.create(content: "There is still no information")

user2_entry = user2.response_entries.build(content: "There is still still no information!")
user2_entry.save
