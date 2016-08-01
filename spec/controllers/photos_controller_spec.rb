require 'rails_helper'

describe PhotosController do
  let(:user) { create(:user) }
  let(:user_2) { create(:user) }

  describe 'GET #index' do
    it 'responds successfully and renders index template' do
      get :index
      expect(response).to be_success
      expect(response).to render_template(:index)
    end

    it 'populates array of photos' do
      photo1 = create(:photo)
      photo2 = create(:photo)
      get :index
      expect(assigns(:photos)).to contain_exactly(photo1, photo2)
    end
  end

  describe 'GET #show' do
    let(:photo) { create(:photo) }

    it 'responds successfully and renders show template' do
      get :show, params: { id: photo }
      expect(response).to be_success
      expect(response).to render_template(:show)
    end

    it 'assigns requested photo to @photo' do
      get :show, params: { id: photo }
      expect(assigns(:photo)).to eq photo
    end
  end

  describe 'GET #new' do
    context 'as logged in user' do
      before { login_user(user) }

      it 'responds successfully and renders new template' do
        get :new
        expect(response).to be_success
        expect(response).to render_template(:new)
      end

      it 'assigns a new Photo to @photo' do
        get :new
        expect(assigns(:photo)).to be_a_new(Photo)
      end
    end

    context 'as not logged in user' do
      it 'redirects to login page' do
        get :new
        expect(response).to_not be_success
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'GET #edit' do
    let(:photo) { create(:photo, user: user) }

    context 'logges as user associated with photo' do
      before { login_user(user) }

      it 'responds successfully and renders edit template' do
        get :edit, params: { id: photo }
        expect(response).to be_success
        expect(response).to render_template(:edit)
      end

      it 'assigns requested photo to @photo' do
        get :edit, params: { id: photo }
        expect(assigns(:photo)).to eq photo
      end
    end

    context 'logges as user not associated with photo' do
      before { login_user(user_2) }

      it 'finds requested photo' do
        expect {
          get :edit, params: { id: photo }
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'as not logged in user' do
      it 'redirects to login page' do
        get :edit, params: { id: photo }
        expect(response).to_not be_success
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'POST #create' do
    context 'as logged in user' do
      before { login_user(user) }

      context 'with valid attributes' do
        it 'save new photo' do
          expect {
            post :create, params: { photo: { title: 'Tytuł zdjęcia', description: 'Opis' }}
          }.to change(Photo, :count).by(1)
        end

        it 'save new photo with expected attributes' do
          post :create, params: { photo: { title: 'Tytuł zdjęcia', description: 'Opis' }}
          expect(Photo.count).to be > 0
          expect(Photo.last.title).to eq 'Tytuł zdjęcia'
          expect(Photo.last.description).to eq 'Opis'
        end

        it 'redirects to show page' do
          post :create, params: { photo: { title: 'Tytuł zdjęcia', description: 'Opis' }}
          expect(response).to redirect_to photo_path(1)
        end
      end
      context 'with invalid attributes' do
        it 'does not save new photo' do
          expect {
            post :create, params: { photo: { title: 'Tytuł zdjęcia' }}
          }.to_not change(Photo, :count)
        end

        it 're-renders the :new template' do
          post :create, params: { photo: { title: 'Tytuł zdjęcia' }}
          expect(response).to render_template :new
        end
      end
    end

    context 'as not logged in user' do
      it 'redirects to login page' do
        get :new
        expect(response).to_not be_success
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'POST #update' do
    let(:photo) { create(:photo, title: 'Tytuł', user: user) }

    context 'logges as user associated with photo' do
      before { login_user(user) }

      it 'finds requested photo' do
        put :update, params: { id: photo, photo: { title: 'Nowy Tytuł' }}
        expect(assigns(:photo)).to eq photo
      end

      context 'valid attributes' do
        it 'changes photo's attributes' do
          put :update, params: { id: photo, photo: { title: 'Nowy Tytuł' }}
          photo.reload
          expect(photo.title).to eq 'Nowy Tytuł'
        end

        it 'redirects to updated photo' do
          put :update, params: { id: photo, photo: { title: 'Nowy Tytuł' }}
          expect(response).to redirect_to photo
        end
      end

      context 'invalid attributes' do
        it 'changes photo's attributes' do
          put :update, params: { id: photo, photo: { title: '' }}
          photo.reload
          expect(photo.title).to eq 'Tytuł'
        end

        it 'redirects to updated photo' do
          put :update, params: { id: photo, photo: { title: '' }}
          expect(response).to render_template :edit
        end
      end
    end

    context 'logges as user not associated with photo' do
      before { login_user(user_2) }

      it 'finds requested photo' do
        expect {
          put :update, params: { id: photo, photo: { title: 'Nowy Tytuł' }}
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'as not logged in user' do
      it 'redirects to login page' do
        put :update, params: { id: photo, photo: { title: 'Nowy Tytuł' }}
        expect(response).to_not be_success
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:photo) { create(:photo, user: user) }

    context 'logges as user associated with photo' do
      before { login_user(user) }

      it 'deletes photo' do
        expect {
          delete :destroy, params: { id: photo }
        }.to change(Photo, :count).by(-1)
      end

      it 'redirects to index page' do
        delete :destroy, params: { id: photo }
        expect(response).to redirect_to photos_url
      end
    end

    context 'logges as user not associated with photo' do
      before { login_user(user_2) }

      it 'finds requested photo' do
        expect {
          delete :destroy, params: { id: photo }
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'as not logged in user' do
      it 'redirects to login page' do
        delete :destroy, params: { id: photo }
        expect(response).to_not be_success
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
