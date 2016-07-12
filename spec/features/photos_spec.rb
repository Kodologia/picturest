require 'features_helper'

describe 'Photos' do
  it 'creates photo' do
    visit root_path
    click_link 'Zdjęcia'
    click_link 'Dodaj zdjęcie'
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

  it 'updates photo' do
    photo = create(:photo_with_file, title: 'title', description: 'description')
    visit root_path
    click_link 'Zdjęcia'
    click_link 'Edytuj'
    expect(page).to have_content 'Edycja zdjęcia'
    expect(page).to have_field('Tytuł', with: photo.title)
    expect(page).to have_field('Opis', with: photo.description)

    fill_in 'Tytuł', with: ''
    fill_in 'Opis', with: 'updated_description'
    click_button 'Zapisz zdjęcie'

    photo.reload
    expect(photo.title).to eq 'title'
    expect(photo.description).to eq 'description'
    expect(page).to have_content 'Nie można zaktualizować zdjęcia.'

    fill_in 'Tytuł', with: 'updated_title'
    click_button 'Zapisz zdjęcie'
    expect(page).to have_content 'Zaktualizowano zdjęcie.'

    photo.reload
    expect(photo.title).to eq 'updated_title'
    expect(photo.description).to eq 'updated_description'
  end
end


