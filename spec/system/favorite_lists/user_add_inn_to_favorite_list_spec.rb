require 'rails_helper'

describe 'Usuário adiciona pousada a lista de favoritos' do
  it 'com sucesso' do
    inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida', 
                                 document: '53783222001', email: 'joao@email.com', password: '123456')
    inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199', description: 'Um bom lugar', 
                          address_attributes: { address: 'Rua X', number: '100', city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})
    joao = User.create!(name: 'Joao', lastname: 'Almeida', 
                        cpf: '53783222001', email: 'joao@email.com', password: '123456')
    FavoriteList.create!(name: 'Pousadas de natal', user: joao)

    login_as joao
    visit root_path
    click_on 'Pousada do Almeidinha'
    click_on 'Adicionar a favoritos'
    select 'Pousadas de natal', from: 'Suas listas'
    click_on 'Adicionar'

    expect(page).to have_content 'Pousada adicionada com sucesso'
    expect(page).to have_content 'Pousadas de natal'
    expect(page).to have_link 'Pousada do Almeidinha'
  end
end