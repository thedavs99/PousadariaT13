require 'rails_helper'

describe 'Usuário cria uma lista de favoritos' do
  it 'e precisa estar autenticado' do
    visit root_path

    expect(page).not_to have_content 'Lista de favoritos'
  end

  it 'com sucesso' do
    user = User.create!(name: 'Joao', lastname: 'Almeida', 
                        cpf: '53783222001', email: 'joao@email.com', password: '123456')

    login_as user
    visit root_path
    click_on 'Lista de favoritos'
    click_on 'Criar lista'
    fill_in 'Nome', with: 'Viagem de natal'
    click_on 'Enviar'

    expect(page).to have_link 'Viagem de natal'
  end

  it 'e nome não pode ficar em branco' do
    user = User.create!(name: 'Joao', lastname: 'Almeida', 
                        cpf: '53783222001', email: 'joao@email.com', password: '123456')

    login_as user
    visit root_path
    click_on 'Lista de favoritos'
    click_on 'Criar lista'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content 'Nome não pode ficar em branco'
  end
end
