# frozen_string_literal: true

require 'test_helper'

class MastersControllerTest < ActionDispatch::IntegrationTest
  test 'should get consult' do
    get masters_consult_url
    assert_response :success
  end
end
