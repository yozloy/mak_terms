require 'sinatra'
require 'mongo'
class MyApp < Sinatra::Base
	get '/' do
		"Today is good"
	end

	get '/:name' do |n|
	db = Mongo::Connection.new('mongoc2.grandcloud.cn',10003).db('terms')
	db.authenticate('yozloy','0054444944')
	coll = db.collection('drum')
	str =coll.find(:English=>n).to_a[0]['Chinese']
	"The Chinese Translation of #{n} is #{str}"
	end
end
