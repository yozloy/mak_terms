require 'sinatra'
require 'mongo'
class MyApp < Sinatra::Base
	set :public_folder, File.dirname(__FILE__) + '/statics'
	get '/search' do
<<HERE
  <form action="search" method="post">
	<input type="text" name="name[word]" />
	<input type="submit" name="get the Chinese" />
	</form>
	<div id="myDiv"><h2>Let AJAX change this text</h2></div>
	<button type="button" onclick="loadXMLDoc()">Change Content</button>
	<script type="text/javascript">
		function loadXMLDoc()
		{
		httpxml = new window.XMLHttpRequest;
		httpxml.open('GET','resources/text/test.txt',true);
		httpxml.send();
		httpxml.onreadystatechange = function() {
			if(httpxml.readyState == 3) {
				document.getElementById('myDiv').innerHTML = 'Loading...';
			}
			if(httpxml.readyState == 4){
				document.getElementById("myDiv").innerHTML= httpxml.responseText;
				}
			}
		}
	</script>
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
