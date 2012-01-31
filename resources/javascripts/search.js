		function removeBox(id){
			var target = document.getElementById(id);
			target.style.display = "none";
		}
		function removeSelf(node){
			while (node.hasChildNodes()) {node.removeChild(node.firstChild)}
		}
	function showHint() {
			var ul_list = document.getElementById('suggestion_box');
			removeBox('suggestion_box');
			removeSelf(ul_list);	
			var input_value = document.getElementById('tags').value;
			console.log(input_value);
			xmlhttp = new XMLHttpRequest();
			xmlhttp.open('GET', 'fetch/names?input='+input_value,true);
			xmlhttp.send();
			xmlhttp.onreadystatechange = function()
			{
				if(xmlhttp.readyState ==4)
				{
					document.getElementById('suggestion_box').style.display = 'block';
					 text_array = xmlhttp.responseText.split(',');
					text_array.pop();
					var keys = text_array.length; 
					var ul_node = document.getElementById('suggestion_box');
					for(var i=0; i < keys; i++){
						var english = text_array[i].split('-')[0]; 
						var chineses = text_array[i].split('-')[1].split(';');
						split_array = text_array[i].split('-');
						new_li = document.createElement('li');	
						new_a = document.createElement('a');
						new_a.href = "/terms/" + english;
						new_a.innerHTML = english +'-'+ chineses[0];
						new_li.appendChild(new_a);
						ul_node.appendChild(new_li);
					}
					
				}
			}
	}
