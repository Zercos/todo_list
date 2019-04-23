Rails.application.routes.draw do

  root 'task_lists#index'

  get 'account', to: 'accounts#show'
  patch 'account', to: 'accounts#update'

  resources :task_lists, only: %i(index create update show destroy)
  resources :tasks, only: %i(index create update show destroy)
  resources :labels, only: %i(index create update show destroy) do
    member do
      get :tasks
      post :assign_to_task
      get :task_lists
      post :assign_to_task_list
      get :task_lists_and_tasks
    end
  end
end