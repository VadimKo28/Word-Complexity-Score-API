Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :complexity_results, only: [:create, :show], path: 'complexity-score', param: :job_id
end
