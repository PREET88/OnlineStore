package onlinestore.servlets;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import onlinestore.model.*;

@WebServlet("/OrderProcesser")
public class OrderProcesser extends HttpServlet {
	// Initialize global variables
	public void init() throws ServletException {
	}

	// Process the HTTP Get request
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(true);
		ShoppingCart cart;
		synchronized (session) {
			cart = (ShoppingCart) session.getAttribute("ShoppingCart");
			// New visitors get a fresh shopping cart.
			// Previous visitors keep using their existing cart.
			if (cart == null) {
				cart = new ShoppingCart();
				session.setAttribute("ShoppingCart", cart);
			}
			String itemID = request.getParameter("itemID");
			if (itemID != null) {
				String numItemsString = request.getParameter("numItems");
				if (numItemsString == null) {
					// If request specified an ID but no number,
					// then customers came here via an "Add Item to Cart"
					// button on a catalog page.
					cart.addItem(itemID);
				} else {
					// If request specified an ID and number, then
					// customers came here via an "Update Order" button
					// after changing the number of items in order.
					// Note that specifying a number of 0 results
					// in item being deleted from cart.
					int numItems;
					try {
						numItems = Integer.parseInt(numItemsString);
					} catch (NumberFormatException nfe) {
						numItems = 1;
					}
					cart.setNumOrdered(itemID, numItems);
				}
			}
		} // end synchronized
		RequestDispatcher dispatcher = request.getRequestDispatcher(response.encodeURL("ShowOrder.jsp"));
		dispatcher.forward(request, response);
	}

	// Process the HTTP Post request
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

	// Clean up resources
	public void destroy() {
	}
}