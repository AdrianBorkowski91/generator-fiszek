package pl.generateflashcards.parse;

import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import pl.generateflashcards.model.Fiche;

public class ReadFileCSV extends ParseProvider{
	
	public List<Fiche> createList(InputStream fileInputStream) throws FileNotFoundException{
		List<Fiche> listFlashcards= new ArrayList<Fiche>();
		
		try(Scanner sc = new Scanner(fileInputStream, "Cp1250")){			
			
			while(sc.hasNextLine()) {
				String line = sc.nextLine();
				String[] words= line.split(";");
				Fiche f= new Fiche(words[0], words[1]);
				listFlashcards.add(f);
			}			
		} 
	return listFlashcards;
	}

}
