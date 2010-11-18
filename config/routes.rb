JxbMe::Application.routes.draw do
  resources :sites, :only => [:create, :show, :new]
  match '/:url' => 'sites#go', :url => /[a-zA-Z0-9]{1,6}/, :as => :shortened
  match '/:url' => 'sites#go', :url => /[0-1]+/, :as => :lengthened
  root :to => 'sites#new'
end
