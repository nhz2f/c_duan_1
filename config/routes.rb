Rails.application.routes.draw do
  match('/index', to: 'infos#index', via: 'post')
  match('/search', to: 'infos#search', via: 'get')
  root 'infos#search'
end
