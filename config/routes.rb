ActionController::Routing::Routes.draw do |map|

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  map.admin_root "/admin", :controller => "admin/home"
  map.admin_login "/admin/login", :controller => "admin/home", :action => "login"
  map.admin_logout "/admin/logout", :controller => "admin/home", :action => "logout"

  map.namespace :admin do |admin|
    admin.resources :pages, :collection => { :sort => :put }
    admin.resources :home_pages, :controller => "pages"
    admin.resources :static_pages, :controller => "pages"
    admin.resources :contact_pages, :controller => "pages"
    admin.resources :portfolios, :controller => "pages"
    admin.resources :works
    admin.resources :posts
    admin.resources :products
    admin.resources :categories
    admin.resources :product_categories, :controller => "categories"
    admin.resources :work_categories, :controller => "categories"
    admin.resources :pictures#, :only => [:create, :delete]
  end
    
  map.work '/galeria/:id', :controller => 'works', :action => 'show', :requirements => {:id => /\d/}
  map.works '/galeria', :controller => 'works', :action => 'index'
  map.works_category '/galeria/:category_id', :controller => 'works', :action => 'index'
  map.product '/produkty/:id', :controller => 'products', :action => 'show', :requirements => {:id => /\d/}
  map.products '/produkty', :controller => 'products', :action => 'index'
  map.products_category '/produkty/:category_id', :controller => 'products', :action => 'index'
  map.resources :posts
  map.resources :categories
  map.page '/:id', :controller => "pages", :action => "show", :conditions => {:parent_id => nil}

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "pages", :action => "show"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
