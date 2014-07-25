Rails.application.routes.draw do
  match('/index', to: 'infos#index', via: 'get')
  root 'infos#index'
end
