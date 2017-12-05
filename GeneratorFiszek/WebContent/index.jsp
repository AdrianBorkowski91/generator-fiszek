<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.css" type="text/css" rel="stylesheet">

<style>

a.sort-a{
    text-decoration: none;
    color: black;
}
img.sort-img{
	width: 15px;
	height: 15px;
}
#table-words{
	text-align: center;
}
div.table-div{
	margin-top: 10px;
}
table.table{
	border: 1px solid black;
}
thead.table-thead{
	background: Gainsboro;
}
th.table-th {
    border: 1px solid black;
    text-align: center;
}
td.table-td {
	padding: 0px;
	border: 1px solid black;
}
input.table-field {
	border: white; 
	width: 100%; 
	height: 100%;
	text-align: center; 
}
div.table-button{
	margin-bottom: 10px;
	float: right;
}
.modal {
    display: none;
    position: fixed;
    z-index: 1; 
    padding-top: 100px; 
    left: 0;
    top: 0;
    width: 100%; 
    height: 100%; 
    overflow: scroll; 
    background-color: rgb(0,0,0);
    background-color: rgba(0,0,0,0.9); 
}
.close {
    position: absolute;
    top: 15px;
    right: 35px;
    color: #f1f1f1;
    font-size: 40px;
    font-weight: bold;
    transition: 0.3s;
}
.close:hover,
.close:focus {
    color: #bbb;
    text-decoration: none;
    cursor: pointer;
}
.btn-img{
	height: 35px; 
	font-size: 12px; 
	border: 1px solid grey; 
	border-radius: 5px;"
}
.options {
	width: 40%;
	font-size: 15px;
	height: 38px;
}
</style>

	<title>Generator fiszek</title>
</head>
<body>

	<nav class="navbar navbar-light bg-light">
		<h2>Generator fiszek</h2>
	</nav>

	<div class="card text-center">
	  <div class="card-header">
	    <ul class="nav nav-tabs card-header-tabs">
	      <li class="nav-item">
	        <button class="nav-link active" onclick="methodCreate()" id="create">Stwórz fiszki</button>
	      </li>
	      <li class="nav-item">
	        <button class="nav-link" onclick="methodExport()" id="export">Eksportuj plik</button>
	      </li>
	    </ul>
	  </div>
	</div>
	
	<form method="post" action="Controller">
    <div class="card-body" id="create-card">   
	    <p class="card-text">Stwórz własną grupę fiszek, a następnie wygeneruj plik z nimi.</p>
	    <div class="input-group">
		  <input type="text" class="form-control" placeholder="Język obcy" id="untranslated-word">
		  <input type="text" class="form-control" placeholder="Tłumaczenie" id="translated-word">
		  <button type="button" class="btn btn-secondary" onclick="addWord()">Dodaj</button>
		</div> 
		
		<div class="table-div">
			<table class="table" id="table-words">
			  <thead class="table-thead">
			  <tr>
			     <th class="table-th" width="40%"><a class="sort-a" href="javascript:;" id="a1" onclick="sortOptions(this)">Język obcy <img class="sort-img" src="resources/icon/minus-3x.png"></a></th>
			     <th class="table-th" width="40%"><a class="sort-a" href="javascript:;" id="a2" onclick="sortOptions(this)">Tłumaczenie <img class="sort-img" src="resources/icon/minus-3x.png"></a></th>
			     <th class="table-th" width="10%">Usuń</th>
			  </tr>
			  </thead>
			</table>
			<div class="table-button">
				<button type="button" onclick="deleteAll()">Usuń wszystkie</button>
			</div>
		</div>
		<input type="button" class="btn btn-primary" value="Wygeneruj fiszki" id="submit1">
    </div>
   		<input type="hidden" id="id-tr" name="id-tr" value="0">
   		<input type="hidden" id="sort-option" value="miss">
	</form>
 
  	<form method="post" action="Controller" action="upload" enctype="multipart/form-data">
	    <div class="card-body" id="export-card" style="display: none;">
		    <p class="card-text">Dodaj plik z roszerzeniem xml, txt, csv, lub xls a następnie wygeneruj plik z nimi.</p>
		 	
		 	<div class="form-group">
			 	<button class="btn btn-link btn-img" type="button" id="picture-xml" onclick="showPicture(this)">PRZYKŁAD XML</button>
				<button class="btn btn-link btn-img" type="button" id="picture-txt" onclick="showPicture(this)">PRZYKŁAD TXT</button>
				<button class="btn btn-link btn-img" type="button" id="picture-csv" onclick="showPicture(this)">PRZYKŁAD CSV/XLS</button>
			</div>
			
		  	<div class="form-group">
		    	<input type="file" class="form-control-file" id="file" name="file" onchange="checkFile()">
		    	<p style="color: red; display: none;" id="message-file">Twój plik ma nieprawidłowe rozszerzenie. Niestety nie jest możliwe, aby wygenerować z niego fiszki.</p>
		  	</div>
	
		    <input type="button" class="btn btn-primary" value="Wygeneruj fiszki" id="submit2">
	
			<div id="modalPicture" class="modal">
				<center><img id="example-picture"></center>
				<span class="close" onclick="closePicture()">&times;</span>
			</div>
	    </div>
	</form>
	
<script>
function methodCreate(){
	document.getElementById("create").className = "nav-link active";	
	document.getElementById("export").className = "nav-link";
	document.getElementById("create-card").style.display = "block"; 
	document.getElementById("export-card").style.display = "none"; 
}
function methodExport(){
	document.getElementById("create").className = "nav-link";	
	document.getElementById("export").className = "nav-link active";
	document.getElementById("create-card").style.display = "none"; 
	document.getElementById("export-card").style.display = "block"; 
}
function addWord(){
	var text1= document.getElementById("untranslated-word").value;
	var text2= document.getElementById("translated-word").value;
	
	if(!isEmpty(text1, text2)){
		var row = document.createElement("tr");
		var count= countId();
		row.setAttribute("id", count+"tr");
		
		for(var i=1; i<=3; i++){
			var cell = document.createElement("td");   
			cell.className="table-td"
			var input = document.createElement("input");
			
			if(i!=3){				
				input.type="text";
				input.className="table-field";
				if(i==1){
					input.setAttribute("name", count+"untranslated");
				}
				else{
					input.setAttribute("name", count+"translated");
				}
				
				if(i==1){
					input.value=text1;
				}
				else{
					input.value=text2;
				}
			}
			else{
				input.type="checkbox";
			}
			cell.appendChild(input);
			row.appendChild(cell);
		}
		
    document.getElementById("table-words").appendChild(row);
    checkSortOption();
    document.getElementById("untranslated-word").value="";
    document.getElementById("translated-word").value="";
	}
	else{
		alert("Musisz uzupełnić dane, aby móc dodać nową fiszkę.")
	}
}
function isEmpty(text1, text2){
	if(text1==null || text1=="" || text2==null || text2==""){ 
		return true;
	}
	return false;
}
function countId(){
	var id= new Number(document.getElementById("id-tr").value);	
	id++;
	
	if(id==1){
		document.getElementById("submit1").type= "submit";
	}
	
	document.getElementById("id-tr").value=id;	
	return id;	
}
function deleteAll(){
	var x= document.getElementById("id-tr").value;
	
	for(var i=1; i<=x; i++){
		var id= i+"tr";
		var z= document.getElementById(id);
		var y = z.getElementsByTagName("input");
		var checked= y[2].checked;		
		if(checked==true){
			var elem= document.getElementById(id).remove();
		}
	}
	newIdRows();
}
function newIdRows(){
	var z= document.getElementById("table-words");
	var x= z.getElementsByTagName("tr");
	
	var i;
    for (i = 1; i < x.length; i++) {
        x[i].setAttribute("id", i+"tr");
    }
    if(x.length-1==0){
    	document.getElementById("submit1").type= "button";
    }
	document.getElementById("id-tr").value=x.length-1;
}
function sortOptions(element){
	var imgs= ["minus-3x.png", "si-glyph-arrow-thin-down.svg", "si-glyph-arrow-thin-up.svg"];
	
	var id= element.id;
	var img= element.getElementsByTagName("img");
	var src= img[0].src;
	
	if(id=="a1"){
		if(src.search(imgs[0])!=-1){			
			changeImg("a2", imgs[0], imgs[1], img[0]);
			sort("untranslated-ascending");
			document.getElementById("sort-option").value="untranslated-ascending";
		}
		else if(src.search(imgs[1])!=-1){
			changeImg("a2", imgs[0], imgs[2], img[0]);	
			sort("untranslated-descending");
			document.getElementById("sort-option").value="untranslated-descending";
		}
		else if(src.search(imgs[2])!=-1){
			changeImg("a2", imgs[0], imgs[1], img[0]);
			sort("untranslated-ascending");
			document.getElementById("sort-option").value="untranslated-ascending";
		}
	}
	else if(id=="a2"){
		if(src.search("minus-3x.png")!=-1){
			changeImg("a1", imgs[0], imgs[1], img[0]);	
			sort("translated-ascending");
			document.getElementById("sort-option").value="translated-ascending";
		}
		else if(src.search("si-glyph-arrow-thin-down.svg")!=-1){
			changeImg("a1", imgs[0], imgs[2], img[0]);	
			sort("translated-descending");
			document.getElementById("sort-option").value="translated-descending";
		}
		else if(src.search("si-glyph-arrow-thin-up.svg")!=-1){
			changeImg("a2", imgs[0], imgs[1], img[0]);
			sort("translated-ascending");
			document.getElementById("sort-option").value="translated-ascending";
		}
	}
}
function changeImg(id, img1Name, img2Name, img2){
	var element= document.getElementById(id);
	var img1= element.getElementsByTagName("img");
	img1[0].src="resources/icon/"+img1Name;
	
	img2.src="resources/icon/"+img2Name;		
}
function sort(option){
	var flashcardsList= getListFlashcards();
	switch(option) {
    case "untranslated-ascending":
    	flashcardsList.sort(function(a,b) {return (a.untranslated > b.untranslated) ? 1 : ((b.untranslated > a.untranslated) ? -1 : 0);} );
        break;
    case "untranslated-descending":
    	flashcardsList.sort(function(a,b) {return (a.untranslated < b.untranslated) ? 1 : ((b.untranslated < a.untranslated) ? -1 : 0);} );
    	break;
    case "translated-ascending":
    	flashcardsList.sort(function(a,b) {return (a.translated > b.translated) ? 1 : ((b.translated > a.translated) ? -1 : 0);} );
    	break;
    case "translated-descending":
    	flashcardsList.sort(function(a,b) {return (a.translated < b.translated) ? 1 : ((b.translated < a.translated) ? -1 : 0);} );
    	break;
	}
	setListToTable(flashcardsList);
}
function getListFlashcards(){
	var flashcardsList=[];
	var fiche;
	var z= document.getElementById("table-words");
	var x= z.getElementsByTagName("tr");

    for (var i=1; i<x.length; i++) {
    	var y= x[i].getElementsByTagName("td");
    	
        	var a= y[0].getElementsByTagName("input")
        	var text1= a[0].value;
        	var b= y[1].getElementsByTagName("input")
        	var text2= b[0].value;
        	
        	fiche= {untranslated: text1, translated: text2};
        	flashcardsList[i-1]=fiche;  	
    }
    return flashcardsList;
}
function setListToTable(flashcardsList){
	var index= document.getElementById("id-tr").value;
	var id;
	
	for (var i=0; i<flashcardsList.length; i++) {
		id=new Number(i+1)+"tr";
		var tr= document.getElementById(id);
		var td= tr.getElementsByTagName("td");	
		
		var inputs1= td[0].getElementsByTagName("input");
		var inputs2= td[1].getElementsByTagName("input");
		
		var input1 =inputs1[0].value= flashcardsList[i].untranslated;
		var input2 =inputs2[0].value= flashcardsList[i].translated;
	}
}
function checkFile(){
	var files= document.getElementById("file");
	var fileName= files.files[0].name;
	var ex= [".xml", ".txt", ".csv", ".xls"];
	var x=0;
	
	for(var i=0; i<ex.length; i++){
		if(fileName.search(ex[i])!=-1){
			x++;
		}
	}
	if(x!=0){
		document.getElementById("message-file").style.display="none";
		document.getElementById("submit2").type= "submit";
	}
	else{
		document.getElementById("message-file").style.display="block";		
		document.getElementById("submit2").type= "button";
	}
}
function checkSortOption(){
	var a= document.getElementById("sort-option").value;
	
	if(a!="miss"){
		switch(a) {
	    case "untranslated-ascending":
	    	sort("untranslated-ascending");
	        break;
	    case "untranslated-descending":
	    	sort("untranslated-descending");
	    	break;
	    case "translated-ascending":
	    	sort("translated-ascending");
	    	break;
	    case "translated-descending":
	    	sort("translated-descending");
	    	break;
		}
	}
}
function showPicture(element){
	var id= element.id;
	var img= document.getElementById("example-picture");
	
	switch(id) {
	    case "picture-xml":
	    	img.src="resources/icon/ex1.png"
	        break;
	    case "picture-txt":
	    	img.src="resources/icon/ex2.png"
	    	break;
	    case "picture-csv":
	    	img.src="resources/icon/ex3.png"
	    	break;
	}
	
	var modal = document.getElementById('modalPicture');
	modal.style.display = "block";
}
function closePicture(){
	var modal = document.getElementById('modalPicture');
	modal.style.display = "none";
}
</script>

	<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.js"></script>

</body>
</html>