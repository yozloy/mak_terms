require 'sinatra'
require 'mongo'
class MyApp < Sinatra::Base
	get '/search' do
<<HERE
  <form action="search" method="post">
	<input type="text" name="name[word]" />
	<input type="submit" name="get the Chinese" />
	</form>
HERE
	end
	post '/search' do
	@word = params[:name][:word]
	redirect to ("/terms/#{@word}")
	end

	get '/terms/:name' do |n|
	db = Mongo::Connection.new('mongoc2.grandcloud.cn',10003).db('terms')
	db.authenticate('yozloy','0054444944')
	coll = db.collection('drum')
	str =coll.find(:English=>n).to_a[0]['Chinese']
	"The Chinese Translation of #{n} is #{str}"
	end
end
