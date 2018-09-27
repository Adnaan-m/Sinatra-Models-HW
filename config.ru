require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require_relative './models/motorbike.rb'
require_relative './controllers/motorbikes_controller.rb'

use Rack::Reloader
use Rack::MethodOverride

run App
