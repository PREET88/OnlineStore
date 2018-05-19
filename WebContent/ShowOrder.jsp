<%@ page
	import="java.util.*, onlinestore.model.*, java.text.NumberFormat"
	contentType="text/html"%>
<HTML>
<HEAD>
<TITLE>Status of Your Order</TITLE>
</HEAD>
<BODY BGCOLOR="#FDF5E6">
	<H1 ALIGN="CENTER">Status of Your Order</H1>
	<%
		ShoppingCart cart = (ShoppingCart) session.getAttribute("ShoppingCart");
		if (cart == null || cart.getNumOrdered() == 0) {
			out.println("<H2><I>No items in your cart...</I></H2>");
			out.println("<a href=\"index.html\">Continue to Shop</a>");
		} else {
	%>
	<TABLE BORDER=1 ALIGN="CENTER">
		<TR BGCOLOR="#FFAD00">
			<TH>Item ID
			<TH>Description
			<TH>Unit Cost
			<TH>Number
			<TH>Total Cost <%
				Vector itemsOrdered = cart.getItemsOrdered();
					ItemOrder order;
					/* Rounds to two decimal places, inserts dollar
					 * sign (or other currency symbol), etc., as
					 * appropriate in current Locale.
					*/
					NumberFormat formatter = NumberFormat.getCurrencyInstance();
					String formURL = "OrderProcesser";

					// Pass URLs that reference own site through encodeURL.
					formURL = response.encodeURL(formURL);
					// For each entry in shopping cart, make table row showing ID, description, per-item
					// cost, number ordered, and total cost. Put number ordered in textfield that user
					// can change, with "Update Order" button next to it, which resubmits to the OrderProcesser page
					// but specifying a different number of items.
					for (int i = 0; i < itemsOrdered.size(); i++) {
						order = (ItemOrder) itemsOrdered.elementAt(i);
			%>
		<TR>
			<TD><%=order.getItemID()%>
			<TD><%=order.getShortDescription()%>
			<TD><%=formatter.format(order.getUnitCost())%>
			<TD><FORM ACTION="<%=formURL%>">
					<INPUT TYPE="HIDDEN" NAME="itemID" VALUE="<%=order.getItemID()%>">
					<INPUT TYPE="TEXT" NAME="numItems" SIZE=3
						VALUE="<%=order.getNumItems()%>"> <SMALL> <INPUT
						TYPE="SUBMIT" VALUE="Update Order">
					</SMALL>
				</FORM>
			<TD><%=formatter.format(order.getTotalCost())%> <%
 	} //end for
 		String checkoutURL = response.encodeURL("/checkout");
 %>
	</TABLE>
	<FORM ACTION="<%=checkoutURL%>">
		<BIG><CENTER>
				<INPUT TYPE="SUBMIT" VALUE="Proceed to Checkout">
			</CENTER></BIG>
	</FORM>
	<%
		} //end else
	%>
	
	<%
		out.println("<a href=\"index.html\">Continue to Shop</a>");
	%>
</body>
</html>
