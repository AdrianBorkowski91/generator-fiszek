package pl.generateflashcards.parse;

import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import pl.generateflashcards.model.Fiche;

public class ReadFileTXT extends ParseProvider{
	
	public List<Fiche> createList(InputStream fileInputStream) throws FileNotFoundException{
		List<Fiche> listFlashcards= new ArrayList<Fiche>();
		
		try(Scanner sc = new Scanner(fileInputStream, "Cp1250")){			
			Pattern p = Pattern.compile(".*,.*;");
			
			while(sc.hasNext()) {
				String line= new String(sc.nextLine());
				Matcher m = p.matcher(line);
				System.out.print(line);
				if(m.find()){
					String words[]= line.split(",");
					String untranslatedWord =  new String(words[0]);
					String translatedWord = new String(words[1].replace(";", ""));
					Fiche f= new Fiche(untranslatedWord, translatedWord);
					listFlashcards.add(f);
				}
			}		
		}

		return listFlashcards;
	}

}
