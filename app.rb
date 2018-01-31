require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'sinatra/activerecord'
require './models'
require './image_uploader.rb'

get '/' do
    @tasks = Task.all
    erb :index
end

get '/tasks/new' do
    @tasks = Task.all
 erb :new
end

post '/tasks' do
    Task.create({
        title:    params[:title],
        sentence: params[:sentence],
        word:     params[:word],
        img:      ""
    })
    
    if params[:file]
        image_upload(params[:file])
    end
    
    redirect '/'
end

post '/tasks/:id/delete' do
    task = Task.find(params[:id])
    task.destroy
    redirect '/'
end

get '/tasks/:id/edit' do
   @task = Task.find(params[:id])
   erb :edit
end

post '/tasks/:id' do
    task = Task.find(params[:id])
    date = params[:due_date].split('-')

    if Date.valid_date?(date[0].to_i, date[1].to_i, date[2].to_i)
      task.title = params[:title]
      task.due_date = Date.parse(params[:due_date])
      task.save
      redirect '/'
    else
    redirect "/tasks/#{task.id}/edit"
  end
end
