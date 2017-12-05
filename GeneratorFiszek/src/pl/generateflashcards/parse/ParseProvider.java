package pl.generateflashcards.parse;

import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.List;

import pl.generateflashcards.model.Fiche;


public abstract class ParseProvider {
	
	public abstract List<Fiche> createList(InputStream fileInputStream) throws FileNotFoundException;
}
