class TestController < ApplicationController
  def test
    article = Article.first
    result = article_format(
      article,
      user: user_format(article.user),
      comments: Proc.new do |ari|
        ari.comments.includes(:user).map do |comment|
          comment_format(
            comment,
            user: user_format(comment.user)
          )
        end
      end
    )
    render json: result
  end

  def article_format(article, options = {})
    handle_expand(article, options) do |article|
      {
        id: article.id,
        title: article.title,
        text: article.text
      }
    end
  end

  def user_format(user)
    {
      id: user.id,
      name: user.name
    }
  end

  def comment_format(comment, options = {})
    handle_expand(comment, options) do |comment|
      {
        id: comment.id,
        commenter: comment.commenter,
        body: comment.body
      }
    end
  end

  def handle_expand(object, options = {})
    return unless block_given?
    basic = yield(object)

    options.keys.each do |attr|
      if options[attr].respond_to?(:call)
        basic.merge!(attr => options[attr].call(object))
      else
        basic.merge!(attr => options[attr])
      end
    end

    basic
  end
end
