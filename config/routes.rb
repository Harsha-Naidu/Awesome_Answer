Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get("/",{to:"welcome#index", as: :root})

  # # ROUTES FOR QUESTIONS
  # get('/questions', to:"questions#index")
  # get('/questions/new', to: "questions#new", as: :new_question)
  # post('/questions', to: "questions#create")

  # get('/questions/:id', to: 'questions#show', as: :question) # once click the title this will render
  # # http://localhost:3000/questions/9
  # delete("/questions/:id",to: "questions#destroy")
  # get('/questions/:id/edit', to: "questions#edit", as: :edit_question)
  # patch('/questions/:id', to: "questions#update")
  # #resources :questions


  # resources will built a CRUD RESTfull routes.(all of the above routes)
  # It assumes that there will be a contoller name as a first argument, pluralized and PascalCase
  # PascalCase
  resources :questions do
    # All the resource
    # /questions/:question_id 
    # So we can now grab question_id from params like params[:question_id]
    resources :answers, only:[:create, :destroy]
    # this will only generate routes for :create and :destroy action
    # /questions/:question_id/answers/:id
    # /questions/:question_id/answers/:id/edit 

  end
  resources :users, only:[:new, :create]
  resource :session, only:[:new, :create, :destroy]
   # resource is singular instead of resources
  # Unlike resources, resource will create routes that do CRUD operations only on one thing. 
  # There will be no index routes and no route will have an :id wildcard
  # Even with singular resource controller will still be plural.
end
