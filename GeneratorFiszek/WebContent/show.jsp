<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
    <link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.css" type="text/css" rel="stylesheet">
<style>
span.all-correct{
	color: green;
}
span.all-incorrect{
	color: red;
}
input.text-word{
	width: 50%;
}
div#table-report{
	display: none; 
	text-align: left; 
	width: 100%;
}
div#widow-words{
	padding-bottom: 10px;
}
</style>

<title>Insert title here</title>
</head>
<body>

	<nav class="navbar navbar-light bg-light">
		<h2>Generator fiszek</h2>
	</nav>
	
	<div class="card text-center">
		<div class="card-header">Ilość słów: <span id="count-actual-words"></span>/<span id="count-all-words"></span><br>
			<span class="all-correct" >POPRAWNE: </span><span class="all-correct" id="count-correct">0</span>
			<span class="all-incorrect" >NIEPOPRAWNE: </span><span class="all-incorrect" id="count-incorrect">0</span>
		</div>
		<div class="card-body">
		    <h4 class="card-title" id="h4-untranslatedWord" ></h4>
		    <div id="widow-words">
		   		<input class="text-word" type="text" id="check-word" style="display: none;">
		   		<span id="proper-word" ></span>
		    </div>
		    <button class="btn btn-outline-primary" id ="check-button" onclick='checkWord()' style="display: none;">Sprawdź</button>
		    <button class="btn btn-outline-primary" id ="next-button" onclick='nextWord()' style="display: none;">Dalej</button>
		    <button class="btn btn-outline-primary" id ="start-button" onclick='startGame()' style="display: inline-block;">Rozpocznij</button>
		</div>
		
		<div class="card-body" id="table-report"></div>			
	</div>

<script>
var listFlashcards= [];
var index=0;
var actualWords=0;
var round=1;

<c:forEach var="f" items="${listFlashcards}">
	var untranslatedWord= '${f.untranslatedWord}';
	var translatedWord= '${f.translatedWord}';

	var fiche= {untranslated: untranslatedWord, translated: translatedWord, included: false , numberIncorrect: 0};
	listFlashcards[index]=fiche;  
	index++;
</c:forEach> 

shuffle(listFlashcards);
index=0;
document.getElementById('count-all-words').innerHTML= allWords();
document.getElementById('count-actual-words').innerHTML= actualWords;

function shuffle(a) {
	var list= a;
    var x, y;
    var length= list.length*10;

    for (var i=0; i<=length; i++) {
        var j = Math.floor(Math.random()*list.length);
        var k = Math.floor(Math.random()*list.length);  
        x= list[j];
        y= list[k];
        list[j]=y;
        list[k]=x;
    }
}

function startGame(){
	shuffle(listFlashcards);
	nextWord();
}
function stopGame(){
	actualWords=0;
	document.getElementById('count-actual-words').innerHTML= actualWords;	
	document.getElementById('count-all-words').innerHTML= allWords();
	
	document.getElementById('check-word').style.display= 'none';
	document.getElementById("check-button").style.display = "none"; 
	document.getElementById('next-button').style.display= 'none';	
	document.getElementById('proper-word').style.color= 'black';
	
	if(isFinish()){
		document.getElementById('h4-untranslatedWord').innerHTML= '';
		document.getElementById('proper-word').innerHTML= 'Wszystkie słowa zostały odgadnięte.';
		document.getElementById("start-button").style.display = "none"; 
		createReport();
	}
	else{
		document.getElementById('h4-untranslatedWord').innerHTML= 'KONIEC '+round+' TURY!';
		++round;
		document.getElementById('proper-word').innerHTML= 'Jeśli chcesz powtórzyć niepoprawnie wpisane przez Ciebie słowa kliknij "Rozpocznij".';	
		document.getElementById("start-button").style.display = "inline-block"; 
		index=0;
	}
}
function nextWord(){	
	try{
		while(listFlashcards[index].included==true){
			index++;
		}
	}catch(err) {}
	
	if(index>=listFlashcards.length){
		stopGame();
	}
	else{
		document.getElementById('proper-word').innerHTML= '';
		document.getElementById('check-word').style.display= 'inline-block';
		document.getElementById('check-button').style.display= 'inline-block';
		document.getElementById('next-button').style.display= 'none';	
		document.getElementById('start-button').style.display= 'none';	
		document.getElementById('h4-untranslatedWord').innerHTML= listFlashcards[index].untranslated;
		index++;
		
		actualWords++;
		document.getElementById('count-actual-words').innerHTML= actualWords;	
	}
}
function checkWord(){
	var checkWord=document.getElementById('check-word').value;
	var correctWord=listFlashcards[index-1].translated;
	
	if(index<=listFlashcards.length){	
		equalsWords(checkWord, correctWord);
	}
}
function equalsWords(checkWord, correctWord){
	elementsNext();
	
	if(checkWord == correctWord){
		var count= new Number(document.getElementById('count-correct').innerHTML);
		count= ++count;
		document.getElementById('count-correct').innerHTML= count;
			
		if(listFlashcards[index-1].numberIncorrect!=0){
			var count= new Number(document.getElementById('count-incorrect').innerHTML);
			count= --count;
			document.getElementById('count-incorrect').innerHTML= count;
		}
		
		listFlashcards[index-1].included= true;

		document.getElementById('proper-word').innerHTML= correctWord +" ✓";
		document.getElementById('proper-word').style.color= 'green';
	}
	else{
		if(listFlashcards[index-1].numberIncorrect==0){
			var count= new Number(document.getElementById('count-incorrect').innerHTML);
			count= ++count;
			document.getElementById('count-incorrect').innerHTML= count;
		}

		var n= new Number(listFlashcards[index-1].numberIncorrect);
		n++;
		listFlashcards[index-1].numberIncorrect= n;
		
		listFlashcards[index-1].included= false;
		
		document.getElementById('proper-word').innerHTML= correctWord+" ✗";
		document.getElementById('proper-word').style.color= 'red';
	}	
}
function elementsNext(){
	document.getElementById('next-button').style.display= 'inline-block';	
	document.getElementById('check-button').style.display= 'none';	
	document.getElementById('check-word').value='';
	document.getElementById('check-word').style.display= 'none';	
}
function createReport(){
	listFlashcards.sort(function(a,b) {return (a.untranslated > b.untranslated) ? 1 : ((b.untranslated > a.untranslated) ? -1 : 0);} );
	document.getElementById('table-report').style.display = "inline-block"; 
	var table = document.createElement("table");
	table.style.width = "100%";
	
	for (var i=0; i<listFlashcards.length; i++){
		var row = document.createElement("tr");
		
		for(var j=1; j<=2; j++){
			var cell = document.createElement("td");   
			var p= document.createElement("p");
			if(j==1){
				cell.style.width = "25%";
				p.innerHTML= listFlashcards[i].untranslated+"/"+listFlashcards[i].translated;
			}
			else{
				p = document.createElement("p");
				var n= new Number(listFlashcards[i].numberIncorrect);
				for(var k=n; k>-1; k--){
					var span = document.createElement("span");
					var t='';
					if(k==0){
						t+=" ✓";
						span.style.color="green";		
					}
					else{
						t+=" ✗";
						span.style.color="red";
					}
					span.innerHTML = t;
					p.appendChild(span);
				}
			}
			cell.appendChild(p);
			row.appendChild(cell);
		}
		table.appendChild(row);
	}
	document.getElementById('table-report').appendChild(table);
}
function isFinish(){
	var count= new Number(document.getElementById('count-incorrect').innerHTML);
	
	if(count==0)
		return true;
	return false;
}
function allWords(){
	var allWords=0;
	for (var i=0; i<listFlashcards.length; i++){
		if(listFlashcards[i].included== false){
			allWords+=1;
		}
	}
	return allWords;
}
</script>		

	<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.js"></script>
</body>
</html>