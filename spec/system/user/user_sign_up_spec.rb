require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    visit root_path
    click_on 'Entrar como cliente'
    click_on 'Criar nova conta'
    fill_in 'Nome', with: 'David'
    fill_in 'Sobrenome', with: 'Dias'
    fill_in 'CPF', with: '1234981238'
    fill_in 'E-mail', with: 'david@campuscode.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Cadastrar'

    expect(page).to have_content 'david@campuscode.com'
    expect(page).to have_button 'Sair'
    expect(current_path).to eq root_path
  end
end