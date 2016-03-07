Rails.application.routes.draw do
  root 'application#index'

  resource :sessions,  only: [:create, :show, :destroy]

  scope 'resources' do
    resources :admits,    except: [:new, :edit] do
      collection do
        get 'in_icu'
        get 'out_soon'
        get 'today'
        get 'queue'
        get 'check_out_list'
      end
    end

    resources :patients,  except: [:new, :edit]
    resources :rooms,     except: [:new, :edit]

    resources :wards,     except: [:new, :edit]  do
      get 'rooms',    on: :member,  action: :ward_index

      collection do
        get 'rooms',                action: :wards_index
        get 'free'
      end
    end

    resources :check_out, controller: :check_out_steps, only: [:show], path: 'check_out' do
      member do
        put    'start'
        put    'stop'
        delete 'reset'
      end
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
