package pl.generateflashcards.model;

public class Fiche {

	private String untranslatedWord;
	private String translatedWord;
	
	public Fiche(){}
	
	public Fiche(String untranslatedWord, String translatedWord){
		this.untranslatedWord= untranslatedWord;
		this.translatedWord= translatedWord;
	}

	public String getUntranslatedWord() {
		return untranslatedWord;
	}

	public void setUntranslatedWord(String untranslatedWord) {
		this.untranslatedWord = untranslatedWord;
	}

	public String getTranslatedWord() {
		return translatedWord;
	}

	public void setTranslatedWord(String translatedWord) {
		this.translatedWord = translatedWord;
	}

	@Override
	public String toString() {
		return "Fiche [untranslatedWord=" + untranslatedWord + ", translatedWord=" + translatedWord + "]";
	}
	
}


