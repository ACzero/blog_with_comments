class CommentsController < ApplicationController
	def index
		@article = Article.find(params[:article_id])
		@comments = @article.comments
	end

	def create
		@article = Article.find(params[:article_id])
		@comment = @article.comments.new(comment_params)

		if @comment.save
			redirect_to(@article)
		else
			@comments = @article.comments
			@comments.delete(@comment)
			render 'articles/show'
		end
	end

	def edit
		@article = Article.find(params[:article_id])
		@comment = Comment.find(params[:id])
	end

	def update
		@article = Article.find(params[:article_id])
		@comment = Comment.find(params[:id])

		if @comment.update(comment_params)
			redirect_to(@article)
		else
			render 'edit'
		end
	end

	def destroy
		@comment = Comment.find(params[:id])
		@article = Article.find(@comment.article_id)
		@comment.destroy

		redirect_to article_path(@article)
	end

	private
		def comment_params
			params.require(:comment).permit(:commenter, :body)
		end
end
