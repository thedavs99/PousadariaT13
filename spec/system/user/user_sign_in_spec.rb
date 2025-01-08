require 'rails_helper'

describe 'Usuário faz login' do
  it 'com sucesso' do
    User.create(name: 'David', lastname: 'Dias', cpf: '12340495485',
                email: 'david@campuscode.com', password: 'password')

    visit root_path
    click_on 'Entrar como cliente'
    fill_in 'E-mail', with: 'david@campuscode.com'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar'

    expect(page).to have_content 'david@campuscode.com'
    expect(page).to have_button 'Sair'
    expect(current_path).to eq root_path
  end
end