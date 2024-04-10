user1 = User.where(email: "test1@example.com").first_or_create(password: "password", password_confirmation: "password")
user2 = User.where(email: "test2@example.com").first_or_create(password: "password", password_confirmation: "password")

apartments = [
  {
    street: '129 West 81st Street',
    unit: '5A',
    city: 'NY',
    state: 'NY',
    square_footage: '1000',
    price: '2000',
    bedrooms: 1,
    bathrooms: 1.0,
    pets: 'no pets allowed',
    image: 'https://www.hollywoodreporter.com/wp-content/uploads/2015/06/seinfeld_apt.jpg',
    user_id: user1
  },

  {
    street: '217 W 57th St',
    unit: 'PH',
    city: 'NY',
    state: 'NY',
    square_footage: '17545',
    price: '196,000,000',
    bedrooms: 7,
    bathrooms: 11.0,
    pets: 'pets allowed',
    image: 'https://www.zillow.com/homedetails/217-W-57th-St-PH-New-York-NY-10019/2067603580_zpid/',
    user_id: user2
  }
]

apartments.each do |apartment|
  user1.apartments.create(apartment)
  puts "Creating: #{apartment}"
  user2.apartments.create(apartment)
  puts "Creating: #{apartment}"
end

