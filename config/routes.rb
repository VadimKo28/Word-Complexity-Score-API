Rails.application.routes.draw do
  resources :complexity_results, only: [:create, :show], path: 'complexity-score', param: :job_id
end
