package pl.generateflashcards.test;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.junit.Assert;
import org.junit.Test;

import pl.generateflashcards.model.Fiche;
import pl.generateflashcards.parse.ParseProvider;
import pl.generateflashcards.parse.ReadFileCSV;
import pl.generateflashcards.parse.ReadFileTXT;
import pl.generateflashcards.parse.ReadFileXML;

public class TestParse {

	public ParseProvider pp;
	
	@Test
	public void testCSV() throws FileNotFoundException {
		pp= new ReadFileCSV();
		InputStream is= new FileInputStream("WebContent/resources/test/PrzykładCSV.csv");	
		List<Fiche> list=pp.createList(is);	
		List<Fiche> listPattern= generateList();
		assertList(list, listPattern);
	}
	
	@Test
	public void testTXT() throws FileNotFoundException{
		pp= new ReadFileTXT();
		InputStream is= new FileInputStream("WebContent/resources/test/PrzykładTXT.txt");	
		List<Fiche> list=pp.createList(is);	
		List<Fiche> listPattern= generateList();
		assertList(list, listPattern);
	}
	
	@Test
	public void testXML() throws FileNotFoundException{
		pp= new ReadFileXML();
		InputStream is= new FileInputStream("WebContent/resources/test/PrzykładXML.xml");	
		List<Fiche> list=pp.createList(is);	
		List<Fiche> listPattern= generateList();
		assertList(list, listPattern);
	}
	
	public List<Fiche> generateList(){
		List<Fiche> listPattern= new ArrayList<>();
		Fiche f1= new Fiche("cat", "kot");
		Fiche f2= new Fiche("dog", "pies");
		Fiche f3= new Fiche("bird", "ptak");
		
		listPattern.add(f1); listPattern.add(f2); listPattern.add(f3);
		
		return listPattern;
	}
	
	public void assertList(List<Fiche> list, List<Fiche> listPattern){
		for(int i=0; i<3; i++){
			Assert.assertEquals(list.get(i).getTranslatedWord(), listPattern.get(i).getTranslatedWord());	
			Assert.assertEquals(list.get(i).getUntranslatedWord(), listPattern.get(i).getUntranslatedWord());	
		
		}	
	}
}
