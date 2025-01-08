require 'rails_helper'

describe 'inn api' do
  context 'GET /api/v1/inns/1', type: :request do
    it 'e exibe detalhes com sucesso' do
      inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida', 
                                   document: '53783222001', email: 'joao@email.com', password: '123456')
      inn = inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar', 
                                  address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})
      inn_room = inn.inn_rooms.create!(name: 'Quarto com Varanda', size: 35, guest_limit: 3)

      get "/api/v1/inns/#{inn.id}"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["name"]). to eq 'Pousada do Almeidinha'
      expect(json_response["registration_number"]). to eq '30638898000199'
      expect(json_response["description"]). to eq 'Um bom lugar'
      expect(json_response["address"]["address"]). to eq 'Rua X'
      expect(json_response["address"]["number"]). to eq '100'
      expect(json_response["address"]["city"]). to eq 'Manaus'
      expect(json_response["inn_rooms"][0]["name"]). to eq 'Quarto com Varanda'
      expect(json_response["inn_rooms"][0]["guest_limit"]). to eq 3
      expect(json_response["inn_owner"]["name"]). to eq 'Joao Almeida'
      expect(json_response["inn_owner"]["email"]). to eq 'joao@email.com'
    end
  end
end