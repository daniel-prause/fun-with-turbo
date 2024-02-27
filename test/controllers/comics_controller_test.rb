# frozen_string_literal: true

require 'test_helper'

class ComicsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get comics_url
    assert_response :success
  end

  test 'should create a new comic' do
    assert_difference('Comic.count', 1) do
      post comics_url, params: { comic: { name: 'New Comic', author_id: authors(:one).id } }
    end
    assert_response :success
  end

  test 'should not create a new comic with invalid params' do
    assert_no_difference('Comic.count') do
      post comics_url, params: { comic: { name: nil, author_id: authors(:one).id } }
    end
    assert_response :unprocessable_entity
  end

  test 'should destroy the specified comic' do
    comic = comics(:one)
    assert_difference('Comic.count', -1) do
      delete comic_url(comic)
    end
    assert_response :success
  end
end
