class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(name: params[:pet][:name])
    # if params.has_key?("owner_name")
    if !params[:owner_name].empty?
      @pet.owner = Owner.create(name: params["owner_name"])
    else
      # @pet.owner = Owner.find(params["owner_ids.first"])
      Owner.find(params[:pet][:owner_ids].first).pets << @pet
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(params["owner"])
    else
      @pet.owner = Owner.find(params["owner"]["id"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end