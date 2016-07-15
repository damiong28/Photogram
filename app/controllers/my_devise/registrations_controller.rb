class MyDevise::RegistrationsController < Devise::RegistrationsController
  
  def create
    super #when new user is created, follow self
    if resource.save
      resource.follow(resource.id)
    end
  end
end