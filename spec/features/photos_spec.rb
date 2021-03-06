require 'features_helper'

feature 'Photos' do
  let!(:user) { create(:user) }
  let(:user_2) { create(:user) }

  scenario 'creates photo' do
    visit root_path
    click_link 'Zdjęcia'
    click_link 'Dodaj zdjęcie'
    expect(page).to have_content 'Zaloguj się aby uzyskać dostęp.'
    expect(current_path).to eq login_path

    fill_in 'Adres email', with: user.email
    fill_in 'Hasło', with: user.password
    click_button 'Zaloguj się'
    expect(current_path).to eq new_photo_path

    expect(page).to have_content 'Nowe zdjęcie'
    fill_in 'Tytuł', with: 'new_title'
    fill_in 'Opis', with: 'new_description'
    attach_file('Plik zdjęcia', "#{Rails.root}/spec/support/ror.png")
    click_button 'Zapisz zdjęcie'
    expect(page).to have_content 'Utworzono nowe zdjęcie.'

    expect(Photo.count).to eq 1
    photo = Photo.last
    expect(photo.title).to eq 'new_title'
    expect(photo.description).to eq 'new_description'
  end

  scenario 'updates photo' do
    photo = create(
      :photo_with_file, title: 'title1', description: 'desc', user: user
    )
    photo_2 = create(
      :photo_with_file, title: 'title2', description: 'd', user: user_2
    )


    login_user(user)
    visit root_path
    click_link 'Zdjęcia'

    within('tr', text: photo_2.title) do
      expect(page).to_not have_link 'Edytuj'
      expect(page).to_not have_link 'Usuń'
    end

    within('tr', text: photo.title) do
      expect(page).to have_link 'Edytuj'
      expect(page).to have_link 'Usuń'
    end

    click_link 'Edytuj'
    expect(page).to have_content 'Edycja zdjęcia'
    expect(page).to have_field('Tytuł', with: photo.title)
    expect(page).to have_field('Opis', with: photo.description)

    fill_in 'Tytuł', with: ''
    fill_in 'Opis', with: 'updated_description'
    click_button 'Zapisz zdjęcie'

    photo.reload
    expect(photo.title).to eq 'title1'
    expect(photo.description).to eq 'desc'
    expect(page).to have_content 'Nie można zaktualizować zdjęcia.'

    fill_in 'Tytuł', with: 'updated_title'
    click_button 'Zapisz zdjęcie'
    expect(page).to have_content 'Zaktualizowano zdjęcie.'

    photo.reload
    expect(photo.title).to eq 'updated_title'
    expect(photo.description).to eq 'updated_description'
  end
end
