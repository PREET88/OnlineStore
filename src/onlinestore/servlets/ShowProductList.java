package onlinestore.servlets;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

import onlinestore.model.*;

@WebServlet("/ShowProductList")
public class ShowProductList extends HttpServlet {
	private Vector techbooklist;
	private Vector kidsbooklist;

	// Initialize global variables
	public void init() throws ServletException {
		techbooklist = new Vector();
		techbooklist.add(ProductList.getItem("lewis001"));
		techbooklist.add(ProductList.getItem("alexander001"));
		techbooklist.add(ProductList.getItem("rowling001"));
		kidsbooklist = new Vector();
		kidsbooklist.add(ProductList.getItem("hall001"));
		kidsbooklist.add(ProductList.getItem("hall002"));
	}

	// Process the HTTP Get request
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = null;

		String option = request.getParameter("op");
		if (option != null && option.equals("KidsBooks")) {
			dispatcher = request.getRequestDispatcher("ShowList.jsp");
			request.setAttribute("Title", "All-Time Best Children's Fantasy Books");
			request.setAttribute("BookList", kidsbooklist);
			dispatcher.forward(request, response);
		} else if (option != null && option.equals("TechBooks")) {
			dispatcher = request.getRequestDispatcher("ShowList.jsp");
			request.setAttribute("Title", "All-Time Best Computer Books");
			request.setAttribute("BookList", techbooklist);
			dispatcher.forward(request, response);
		} else
			response.sendError(response.SC_BAD_REQUEST, "Bad Request.");
	}

	// Process the HTTP Post request
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	// Clean up resources
	public void destroy() {
	}
}