require 'rails_helper'

RSpec.describe "Apartments", type: :request do
  let(:user) { User.create(
      email: 'test@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
  }

  describe 'GET #index' do
    it 'returns a list of apartments and http success' do
      apartment = user.apartments.create(
        street: 'Test Street',
        unit: 'Test Unit',
        city: 'Test City',
        state: 'Test State',
        square_footage: 1000,
        price: '$1000',
        bedrooms: 1,
        bathrooms: 1.0,
        pets: 'Test Pets',
        image: 'https://c8.alamy.com/comp/B0RJGE/small-bungalow-home-with-pathway-in-addlestone-surrey-uk-B0RJGE.jpg'
      )
      get apartments_path
      expect(response).to have_http_status(200)
      expect(apartment).to be_valid
    end
  end

  describe 'POST #create' do
    it 'creates a valid apartment with http success' do
      post apartments_path, params: {
        apartment: {
          street: 'Test Street',
          unit: 'Test Unit',
          city: 'Test City',
          state: 'Test State',
          square_footage: 1000,
          price: '$1000',
          bedrooms: 1,
          bathrooms: 1.0,
          pets: 'Test Pets',
          image: 'https://c8.alamy.com/comp/B0RJGE/small-bungalow-home-with-pathway-in-addlestone-surrey-uk-B0RJGE.jpg',
          user_id: user.id
        }
      }
      apartment = Apartment.where(street: 'Test Street').first
      expect(response).to have_http_status(200)
      expect(apartment).to be_valid
    end
    
    it 'creates a invalid apartment' do
      post apartments_path, params: {
        apartment: {
          street: nil,
          unit: nil,
          city: nil,
          state: nil,
          square_footage: nil,
          price: nil,
          bedrooms: nil,
          bathrooms: nil,
          pets: nil,
          image: nil,
          user_id: nil
        }
      }
      apartment = Apartment.where(street: nil).first
      expect(response).to have_http_status(422)
      expect(apartment).to eq(nil)
    end
  end

  describe 'PATCH #update' do
    it 'updates a valid apartment with http success' do
      post apartments_path, params: {
        apartment: {
          street: 'Test Street 1',
          unit: 'Test Unit 1',
          city: 'Test City 1',
          state: 'Test State 1',
          square_footage: 1001,
          price: '$1001',
          bedrooms: 11,
          bathrooms: 11.0,
          pets: 'Test Pets1',
          image: 'https://c8.alamy.com/comp/B0RJGE/small-bungalow-home-with-pathway-in-addlestone-surrey-uk-B0RJGE.jpg',
          user_id: user.id
        }
      }
      apartment = Apartment.where(street: 'Test Street 1').first
      patch apartment_path(apartment), params: {
        apartment: {
          street: 'Test Street for patch',
          unit: 'Test Unit for patch',
          city: 'Test City for patch',
          state: 'Test State for patch',
          square_footage: 1500,
          price: '$1000 for patch',
          bedrooms: 3,
          bathrooms: 3.0,
          pets: 'Test Pets for patch',
          image: 'https://c8.alamy.com/comp/B0RJGE/small-bungalow-home-with-pathway-in-addlestone-surrey-uk-B0RJGE.jpg',
          user_id: user.id
        }
      }
      apartment = Apartment.where(street: 'Test Street for patch').first
      expect(apartment.street).to eq('Test Street for patch')
      expect(apartment.unit).to eq('Test Unit for patch')
      expect(apartment.city).to eq('Test City for patch')
      expect(apartment.state).to eq('Test State for patch')
      expect(apartment.square_footage).to eq(1500)
      expect(apartment.price).to eq('$1000 for patch')
      expect(apartment.bedrooms).to eq(3)
      expect(apartment.bathrooms).to eq(3.0)
      expect(apartment.pets).to eq('Test Pets for patch')
      expect(apartment.image).to eq('https://c8.alamy.com/comp/B0RJGE/small-bungalow-home-with-pathway-in-addlestone-surrey-uk-B0RJGE.jpg')
      expect(response).to have_http_status(200)
    end

    it 'returns an http status error for an invalid ' do
      post apartments_path, params: {
        apartment: {
          street: 'Test Street for patch',
          unit: 'Test Unit for patch',
          city: 'Test City for patch',
          state: 'Test State for patch',
          square_footage: 1500,
          price: '$1000 for patch',
          bedrooms: 3,
          bathrooms: 3.0,
          pets: 'Test Pets for patch',
          image: 'https://c8.alamy.com/comp/B0RJGE/small-bungalow-home-with-pathway-in-addlestone-surrey-uk-B0RJGE.jpg',
          user_id: user.id
        }
      }

      apartment = Apartment.where(street: 'Test Street for patch').first 
      expect(apartment).not_to be_nil

      patch apartment_path(apartment.id), params: {
        apartment: {
          street: nil,
          unit: nil,
          city: nil,
          state: nil,
          square_footage: nil,
          price: nil,
          bedrooms: nil,
          bathrooms: nil,
          pets: nil,
          image: nil,
          user_id: user.id
        }
      }
      apartment = Apartment.where(street: nil).first
      expect(response).to have_http_status(422)
    end
  end

  describe 'DELETE #destroy' do
  it 'deletes the apartment' do
    apartment = Apartment.create(
      street: 'Test Street for delete',
      unit: 'Test Unit for delete',
      city: 'Test City for delete',
      state: 'Test State for delete',
      square_footage: 1005,
      price: '$1000 for delete',
      bedrooms: 9,
      bathrooms: 9.0,
      pets: 'Test Pets for delete',
      image: 'https://c8.alamy.com/comp/B0RJGE/small-bungalow-home-with-pathway-in-addlestone-surrey-uk-B0RJGE.jpg',
      user_id: user.id
    )
    delete apartment_path(apartment)
    apartment = Apartment.where(street: 'Test Street for delete').first
    expect(apartment).to eq(nil)
    end
  end
end
