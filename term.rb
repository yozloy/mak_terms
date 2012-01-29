require 'sinatra'
require 'mongo'
#Module Markson
#	def self.connect_mongo(server, port,user,password)
#		db = Mongo::Connection.new(server, port).db('terms')
#		db.authenticate(user,password)
#		db.collection('drum')
#	end
#end
class MakTerm < Sinatra::Base
	set :public_folder, File.dirname(__FILE__) + '/statics'
	#server = 'localhost';	port =  27017
	server = 'mongoc2.grandcloud.cn'; port = 10003
	user = 'yozloy'
	password = '0054444944'

	db = Mongo::Connection.new(server, port).db('terms')
	db.authenticate(user,password)
	@@coll = db.collection('drum')
		

	get '/create' do
		erb :create, :layout => :frame
	end
	post '/create' do
		english = params['English']
		chinese = params['Chinese']
		doc = {English:english, Chinese:chinese}	
		@@coll.insert(doc)
		redirect to ("/search") 
	end
#	get '/client_search' do
#		erb :client_search, layout => :frame
#	end
#	post '/search' do
#	@word = params[:name][:word]
#	redirect to ("/terms/#{@word}")
#	end

	get '/search' do
		erb :search, :layout => :frame
	end

	get '/fetch/names' do  
		str = params['input']
		#new_result_array = []
		new_result_string = ""
		@@coll.find({'English' => /^#{str}/},{:fields => {'_id' => 0}}).each do |result|
			#new_result_array << result['English']
			new_result_string << "#{result['English']}-#{result['Chinese']},"
		end
			new_result_string
	end

	get '/insert/names' do

		doc = {English:params[:english_value], Chinese:params[:chinese_value]}

		if @@coll.insert(doc, {safe:true}) then 
			'Mongodb accept it'
		else
			'Mongodb reject it'
		end
		
	#	'successful'
	#	doc.inspect
	end

	post '/test' do
		"#{params.inspect}"
	end

	get '/test' do
		id = @@coll.find_one()[:_id]
		#doc = { _id:id, English:'paradiddle', 'Chinese' => 'eg'}
		if @@coll.insert({ _id:id, English:'paradiddle', 'Chinese' => 'eg'},
 {safe:true}) then
			"Successful"
		else
			"fail"	
		end
	end
	get '/test1' do
		"Shotgun works!"
	end

	get '/terms/:name' do |n|
	db = Mongo::Connection.new('mongoc2.grandcloud.cn',10003).db('terms')
	db.authenticate('yozloy','0054444944')
	coll = db.collection('drum')
	str =coll.find(:English=>n).to_a[0]['Chinese']
	"The Chinese Translation of #{n} is #{str}"
	end

end
