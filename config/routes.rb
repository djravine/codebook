ActionController::Routing::Routes.draw do |map|


	map.namespace :admin do |admin|
	  admin.resources :posts
	end

  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.forgot '/forgot', :controller => 'users', :action => 'forgot'
  map.activate '/activate', :controller => 'users', :action => 'activate'
	map.simple_captcha '/simple_captcha/:action', :controller => 'simple_captcha'

  map.resource :session
  map.resources :questions, :active_scaffold => true
  map.resources :contacts, :active_scaffold => true
  map.resources :authors, :active_scaffold => true
  map.resources :purposes, :active_scaffold => true
  map.resources :archieves, :active_scaffold => true
  map.resources :users, :has_many => :roles, :active_scaffold => true
  map.resources :usergroups, :has_many => :roles, :has_many => :users, :active_scaffold => true
  map.resources :roles, :belongs_to => :users, :belongs_to => :usergroups, :active_scaffold => true
  map.resources :tags, :belongs_to => :posts, :belongs_to => :downloads, :active_scaffold => true
  map.resources :comments, :belongs_to => :posts, :belongs_to => :users, :active_scaffold => true
  map.resources :posts, :belongs_to => :users, :has_many => :comments, :active_scaffold => true 
  map.resources :downloads, :belongs_to => :users, :has_many => :comments, :active_scaffold => true

  map.root :controller => 'posts'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id/:id2'
 
end