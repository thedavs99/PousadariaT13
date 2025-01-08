require 'rails_helper'

describe 'Usuário remove pousada da lista de favoritos' do
  it 'com sucesso' do 
    inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida', 
                                 document: '53783222001', email: 'joao@email.com', password: '123456')
    inn = inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar', 
                                address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})
    other_inn_owner = InnOwner.create!(first_name: 'David', last_name: 'Dias', 
                                document: '1331363136', email: 'david@email.com', password: '123456')    
    other_inn = other_inn_owner.create_inn!(name: 'Pousada de Papa Noel', registration_number: '30638898000190', description: 'Um bom lugar', 
                                      address_attributes: { address: 'Rua X', number: '100', city: 'Rio de Janeiro', state: 'RJ', postal_code: '69067-080', neighborhood: 'Centro'})
    joao = User.create!(name: 'Joao', lastname: 'Almeida', 
                        cpf: '53783222001', email: 'joao@email.com', password: '123456')
    favorite_list = FavoriteList.create!(name: 'Pousadas de natal', user: joao)
    FavoritesInn.create!(inn: inn, favorite_list: favorite_list)
    FavoritesInn.create!(inn: other_inn, favorite_list: favorite_list)

    login_as joao
    visit root_path
    click_on 'Lista de favoritos'
    click_on 'Pousadas de natal'
    within "div##{inn.id}" do
      click_on 'Remover'
    end

    expect(page).not_to have_link 'Pousada do Almeidinha'
    expect(page).to have_link 'Pousada de Papa Noel'
    expect(page).to have_content 'Pousada removida com sucesso'
  end
end