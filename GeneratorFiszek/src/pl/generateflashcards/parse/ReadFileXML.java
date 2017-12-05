package pl.generateflashcards.parse;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import pl.generateflashcards.model.Fiche;

public class ReadFileXML extends ParseProvider{

	public List<Fiche> createList(InputStream fileInputStream) {
			List<Fiche> listFlashcards= new ArrayList<Fiche>();
	    	DocumentBuilderFactory factory = null;
	    	DocumentBuilder builder = null;

	      try {
	    	factory = DocumentBuilderFactory.newInstance();
	        builder = factory.newDocumentBuilder();
	        Document doc = builder.parse(new InputSource(fileInputStream));
	        doc.getDocumentElement().normalize();
	        
	        NodeList nodeList = doc.getElementsByTagName("fiche");
	        
		        for (int i=0; i<nodeList.getLength(); i++){
		        	Node node = nodeList.item(i);
	
		    		if (node.getNodeType() == Node.ELEMENT_NODE) {
				    	Element element = (Element) node;
				    	Fiche f= new Fiche();
				    	f.setTranslatedWord(element.getElementsByTagName("translated").item(0).getTextContent());
				    	f.setUntranslatedWord(element.getElementsByTagName("untranslated").item(0).getTextContent());
				    	listFlashcards.add(f);
		    		}
		        }
	      	} catch (SAXException e) {
	          e.printStackTrace();
	        } catch (IOException e) {
	          e.printStackTrace();
	        } catch (ParserConfigurationException e) {
	          e.printStackTrace();
	        }

		return listFlashcards;
	}

}
