user = FactoryBot.create(:user)
FactoryBot.create_list(:article, 50, user: user)
puts "seeds completed"
