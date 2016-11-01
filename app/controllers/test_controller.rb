class TestController < ApplicationController
  def test
    render json: { msg: 'ok' }
  end
end
