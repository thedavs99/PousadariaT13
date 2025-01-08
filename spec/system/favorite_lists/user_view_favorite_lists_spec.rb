require 'rails_helper'

describe 'Usuario ve listas de favoritos' do
  it 'e precisa estar autenticado' do
    visit favorite_lists_path

    expect(current_path).to eq new_user_session_path
  end

  it 'e vé mensagem quando a lista está vazia' do
    user = User.create!(name: 'Joao', lastname: 'Almeida', 
                        cpf: '53783222001', email: 'joao@email.com', password: '123456')

    login_as user
    visit root_path
    click_on 'Lista de favoritos'

    expect(page).to have_content 'Você não possui nenhuma lista'
  end

  it 'e não ve as listas dos outros usuarios' do
    joao = User.create!(name: 'Joao', lastname: 'Almeida', 
                        cpf: '53783222001', email: 'joao@email.com', password: '123456')
    david = User.create!(name: 'David', lastname: 'Almeida', 
                        cpf: '53783222001', email: 'david@email.com', password: '123456')
    FavoriteList.create!(name: 'Pousadas de natal', user: joao)
    FavoriteList.create!(name: 'Pousadas de carnaval', user: david)
    

    login_as david
    visit root_path
    click_on 'Lista de favoritos'

    expect(page).to have_link 'Pousadas de carnaval'
    expect(page).not_to have_link 'Pousadas de natal'
  end
end