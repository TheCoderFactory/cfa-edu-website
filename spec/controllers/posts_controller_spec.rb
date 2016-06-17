require 'spec_helper'

describe PostsController do
  describe 'GET #index' do
    context "with a valid user signed in" do
      before :each do
        sign_in
      end

      it "populates an array of all posts" do
        post1 = create(:post)
        post2 = create(:post)
        get :index
        expect(assigns(:posts)).to match_array([post1, post2])
      end
      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    context "without a valid user signed in" do
      before :each do
        sign_in nil
      end

      it "does not populate an array of all posts" do
        create(:post)
        create(:post)
        get :index
        expect(assigns(:posts)).to be_nil
      end
      it "redirects to the sign in page" do
        get :index
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe 'GET #show' do
    before :each do
      @post = create(:post)
    end

    it "assigns the requested post to @post" do
      get :show, id: @post.id
      expect(assigns(:post)).to eq @post
    end
    it "renders the :show page" do
      get :show, id: @post.id
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    context "with a valid user signed in" do
      before :each do
        sign_in
      end

      it "assigns a new post to @post" do
        get :new
        expect(assigns(:post)).to be_a_new(Post)
      end
      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    context "without a valid user signed in" do
      before :each do
        sign_in nil
      end

      it "does not create a new post" do
        get :new
        expect(assigns(:post)).to be_nil
      end
      it "redirects to the sign in page" do
        get :new
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe "POST #create" do
    context "with a valid user signed in" do
      before :each do
        sign_in
      end

      context "with valid attributes" do
        it "saves the new post in the database" do
          expect{
            post :create, post: attributes_for(:post)
          }.to change(Post, :count).by(1)
        end
        it "redirects to post" do
          post :create, post: attributes_for(:post)
          post = Post.last
          expect(response).to redirect_to post_path(post)
        end
      end

      context "with invalid attributes" do
        it "does not save the new post in the database" do
          expect{
            post :create, post: attributes_for(:invalid_post)
          }.to_not change(Post, :count)
        end
        it "re-renders the :new template" do
          post :create, post: attributes_for(:invalid_post)
          expect(response).to render_template :new
        end
      end
    end

    context "with an invalid user signed in" do
      before :each do
        sign_in nil
      end

      it "does not create a new post" do
        expect{
          post :create, post: attributes_for(:post)
        }.to_not change(Post, :count)
      end
      it "redirects to the sign in page" do
        post :create, post: attributes_for(:post)
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe 'GET #edit' do
    context "with a valid user signed in" do
      before :each do
        sign_in
      end

      it "assigns the requested post to @post" do
        post = create(:post)
        get :edit, id: post
        expect(assigns(:post)).to eq post
      end
      it "renders the :edit template" do
        post = create(:post)
        get :edit, id: post
        expect(response).to render_template :edit
      end
    end

    context "with an invalid user signed in" do
      before :each do
        sign_in nil
      end

      it "does not assign the requested post to @post" do
        post = create(:post)
        get :edit, id: post
        expect(assigns(:post)).to be_nil
      end
      it "redirects to the sign in page" do
        post = create(:post)
        get :edit, id: post
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe 'PATCH #update' do
    before :each do
      @post = create(:post, title: "This post", lead: "This lead")
    end

    context "with a valid user signed in" do
      before :each do
        sign_in
      end

      context "with valid attributes" do
        it "locates the requested @post" do
          patch :update, id: @post, post: attributes_for(:post)
          expect(assigns(:post)).to eq(@post)
        end
        it "changes @post's attributes" do
          patch :update, id: @post, post: attributes_for(:post, title: "That post")
          @post.reload
          expect(@post.title).to eq("That post")
        end
        it "redirects to post" do
          patch :update, id: @post, post: attributes_for(:post, title: "That post")
          expect(response).to redirect_to post_path(@post)
        end
      end

      context "with invalid attributes" do
        it "does not change the @post's attributes" do
          patch :update, id: @post, post: attributes_for(:post, title: "That post", lead: nil)
          @post.reload
          expect(@post.title).to_not eq("That post")
          expect(@post.lead).to eq("This lead")
        end
        it "re-renders the #edit template" do
          patch :update, id: @post, post: attributes_for(:invalid_post)
          expect(response).to render_template :edit
        end
      end
    end

    context "with an invalid user signed in" do
      before :each do
        sign_in nil
      end

      it "does not update the post" do
        patch :update, id: @post, post: attributes_for(:post, title: "That post", lead: nil)
        @post.reload
        expect(@post.title).to_not eq("That post")
        expect(@post.lead).to eq("This lead")
      end
      it "redirects to the sign in page" do
        patch :update, id: @post, post: attributes_for(:invalid_post)
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @post = create(:post)
    end

    context "with valid user signed in" do
      before :each do
        sign_in
      end

      it "deletes the post from the database" do
        expect{
          delete :destroy, id: @post
        }.to change(Post, :count).by(-1)
      end
      it "redirects to posts#index" do
        delete :destroy, id: @post
        expect(response).to redirect_to posts_path
      end
    end

    context "with an invalid user signed in" do
      before :each do
        sign_in nil
      end

      it "does not delete the post from the database" do
        expect {
          delete :destroy, id: @post
        }.to_not change(Post, :count)
      end
      it "redirects to the sign in page" do
        delete :destroy, id: @post
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end
end
