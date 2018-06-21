Rails.application.routes.draw do
  root to:           'site#index'
  get '/imports'  => 'site#imports'
  post '/imports' => 'site#imports', as: 'do_imports'
  get '/search'   => 'search#search'
end
