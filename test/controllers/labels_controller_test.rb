require 'test_helper'

class LabelsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:mike)
    @label = labels(:label1)
  end

  test 'should get all user labels' do
    get labels_path, headers: { 'AuthToken' => @user.auth_token }, as: :json

    parsed_body = JSON.parse response.body

    assert_response :success
    assert_equal @user.labels.count, parsed_body['labels'].count
  end

  test 'should create label and render show' do
    assert_difference 'Label.count', 1 do
      post labels_path, params: {label: { name: 'label2', description: 'in' }},
                        headers: { 'AuthToken' => @user.auth_token }, as: :json
    end
    parsed_body = JSON.parse response.body
    new_label = @user.labels.find(parsed_body['label']['id'])

    assert_response :success
    assert_equal 'label2', new_label.name
  end

  test 'should update and render show' do
    patch label_path(@label), params: {label: { name: 'label1', description: 'out' }},
                              headers: { 'AuthToken' => @user.auth_token }, as: :json

    assert_response :success
    assert_equal 'out', @label.reload.description
  end

  test 'should show label' do
    get label_path(@label), headers: { 'AuthToken' => @user.auth_token }, as: :json

    parsed_body = JSON.parse response.body

    assert_response :success
    assert_equal @label.name, parsed_body['label']['name']
  end

  test 'should get task_lists for label' do
    get task_lists_label_path(@label), headers: { 'AuthToken' => @user.auth_token }, as: :json

    parsed_body = JSON.parse response.body
    response_ids = parsed_body['task_lists'].collect { |item| item['id'] }

    assert_response :success
    assert_equal @label.task_lists.ids.sort, response_ids.sort
  end

  test 'should get tasks for label' do
    get tasks_label_path(@label), headers: { 'AuthToken' => @user.auth_token }, as: :json

    parsed_body = JSON.parse response.body

    assert_response :success
    assert_equal @label.tasks.count, parsed_body['tasks'].count
  end

  test 'should get tasks and task_lists for label' do
    get task_lists_and_tasks_label_path(@label), headers: { 'AuthToken' => @user.auth_token }, as: :json

    parsed_body = JSON.parse response.body

    assert_response :success
    assert_equal @label.task_lists.count, parsed_body['task_lists'].count
    assert_equal @label.tasks.count, parsed_body['tasks'].count
  end
end