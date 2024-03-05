# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Drink, type: :model do
  describe '.fetch_and_save_cocktails' do
    before do
      stub_request(:get, "#{Drink::BASE_URL}?page=1")
        .to_return(status: 200, body: {
          total_pages: 1,
          cocktails: [
            {
              cocktail_id: '1',
              cocktail_name: 'Margarita',
              cocktail_desc: 'A classic cocktail...'
            }
          ]
        }.to_json, headers: {})
    end

    it 'APIからカクテルデータを取得し、データベースに保存する' do
      expect { Drink.fetch_and_save_cocktails }.to change(Drink, :count).by(1)

      drink = Drink.last
      expect(drink.name).to eq('Margarita')
      expect(drink.description).to eq('A classic cocktail...')
    end
  end
end
