require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  let(:article){ FactoryGirl.create(:article) }
  let(:article_attributes) { FactoryGirl.attributes_for(:article) }
  let(:article_invalid_attributes) { {:title => "a", :text => "b"} }
  let(:article_new_attributes) { {:title => "kkkaaa", :text => "jjjjjjj"} }

  context 'GET#index' do
    it 'get a article list' do
      get :index
      expect(assigns(:articles)).to eq Article.all
    end

    it 'render index view' do
      get :index
      expect(response).to render_template 'index'
    end
  end 

  context 'GET#show' do
    it 'get a article by id' do
      get :show, id: article.id
      expect(assigns(:article)).to eq Article.find(article.id)
    end

    it 'render show view' do
      get :show, id: article.id
      expect(response).to render_template 'show'
    end
  end

  context 'GET#new' do
    it 'assigns a new article to @article' do
      get :new
      expect(assigns(:article)).to be_a(Article)
    end

    it 'render new view' do
      get :new
      expect(response).to render_template 'new'
    end
  end

  context 'GET#edit' do
    it 'assigns a article by id' do
      get :edit, id: article.id
      expect(assigns(:article)).to eq Article.find(article.id)
    end

    it 'render edit view' do
      get :edit, id: article.id
      expect(response).to render_template 'edit'
    end
  end

  context 'POST#create' do
    context 'with valid attributes' do
      it 'save the article' do
        expect{
          post :create, article: article_attributes
        }.to change(Article,:count).by(1)
      end

      it 'redirect to show @article' do
        post :create, article: article_attributes
        expect(response).to redirect_to article_path(assigns(:article).id)

        puts article_attributes
      end
    end

    context 'with invalid attributes' do
      it 'do not save the artcle' do
        expect{
           post :create, article: article_invalid_attributes
        }.not_to change(Article, :count)
      end

      it 'render new view' do
        post :create, article: article_invalid_attributes
        expect(response).to render_template 'new'
      end
    end
  end

  context 'PATCH#update' do
    context 'with valid attributes' do
      it 'locate the requested @article' do
        patch :update, id: article.id, article: article_new_attributes
        expect(assigns(:article)).to eq(article)
      end

      it 'update the article' do
        patch :update, id: article.id, article: article_new_attributes
        article.reload
        expect(article.title).to eq article_new_attributes[:title]
        expect(article.text).to eq article_new_attributes[:text]
      end

      it 'redirect_to show @article' do
        patch :update, id: article.id, article: article_new_attributes
        expect(response).to redirect_to article_path(article.id)
      end
    end

    context 'with invalid attributes' do
      it 'locate the requested @article' do
        patch :update, id: article.id, article: article_invalid_attributes
        expect(assigns(:article)).to eq(article)
      end

      it 'does not update the article' do
        patch :update, id: article.id, article: article_invalid_attributes
        article.reload
        expect(article.title).not_to eq article_new_attributes[:title]
        expect(article.text).not_to eq article_new_attributes[:text]
      end

      it 'render edit' do
        patch :update, id: article.id, article: article_invalid_attributes
        expect(response).to render_template 'edit'
      end
    end
  end

  context 'DELETE#destroy' do
    let!(:article_to_delete){ FactoryGirl.create(:article) }

    context 'with valid id' do
      it 'locate the @article' do
        delete :destroy, id: article_to_delete.id
        expect(assigns(:article)).to eq article_to_delete
      end

      it 'delete the article' do
        expect{
          delete :destroy, id: article_to_delete.id
          }.to change(Article, :count).by(-1)
      end

      it 'redirect_to index' do
        delete :destroy, id: article_to_delete.id
        expect(response).to redirect_to articles_path
      end
    end
  end

end