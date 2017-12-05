package pl.generateflashcards.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import pl.generateflashcards.model.Fiche;
import pl.generateflashcards.parse.ParseProvider;
import pl.generateflashcards.parse.ReadFileCSV;
import pl.generateflashcards.parse.ReadFileTXT;
import pl.generateflashcards.parse.ReadFileXML;


@WebServlet("/Controller")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private ParseProvider pp;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getSession().getAttribute("listFlashcards")==null){
			doPost(request,response);
		}
		request.getRequestDispatcher("WEB-INF/login.jsp").forward(request, response); 
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		List<Fiche> listFlashcards = new ArrayList<Fiche>();

		int idTr;
		try{
			idTr= Integer.parseInt(request.getParameter("id-tr"));
		}catch(NumberFormatException e){idTr=-1;}

		if(idTr==-1){
		    Part part = request.getPart("file");
		    String fileName = part.getSubmittedFileName();
		    InputStream fileInputStream= part.getInputStream();
		    
		    String split[]= fileName.split("\\.");
		    String ex= split[split.length-1];
		    
		    if(ex.equals("txt")){
		    	pp= new ReadFileTXT();
		    	listFlashcards= pp.createList(fileInputStream);
		    }
		    else if(ex.equals("xml")){
		    	pp= new ReadFileXML();
		    	listFlashcards= pp.createList(fileInputStream);
		    }
		    else{
		    	pp= new ReadFileCSV();
		    	listFlashcards= pp.createList(fileInputStream);
		    }
		    
		}
		else{
			for (int i=1; i<=idTr; i++){
				String modelUntranslated=i+"untranslated";
				String modelTranslated=i+"translated";
				
				String untranslated= request.getParameter(modelUntranslated);
				String translated= request.getParameter(modelTranslated);
				
				Fiche fiche= new Fiche (untranslated, translated);
				listFlashcards.add(fiche);
			}
		}
		
        request.getSession().setAttribute("listFlashcards", listFlashcards);     
        request.getRequestDispatcher("show.jsp").forward(request, response);  
	}

}
