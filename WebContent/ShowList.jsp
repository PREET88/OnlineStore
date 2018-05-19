<%@ page import="java.util.*, onlinestore.model.*"
	contentType="text/html"%>
<HTML>
<HEAD>
<TITLE><%=(String) request.getAttribute("Title")%></TITLE>
</HEAD>
<BODY BGCOLOR="#FDF5E6">
	<H1 ALIGN="CENTER"><%=(String) request.getAttribute("Title")%></H1>
	<HR>

	<%
		Vector v = (Vector) request.getAttribute("BookList");
		Item item = null;
		for (int i = 0; v != null && i < v.size(); i++) {
			item = (Item) v.elementAt(i);
	%>
	<FORM ACTION="OrderProcesser">
		<INPUT TYPE="HIDDEN" NAME="itemID" VALUE="<%=item.getItemID()%>">
		<H2><%=item.getShortDescription()%>
			($<%=item.getCost()%>)
		</H2>
		<%=item.getLongDescription()%>
		<P>
		<CENTER>
			<INPUT TYPE="SUBMIT" VALUE="Add to Shopping Cart">
		</CENTER>
		<P>
	</FORM>
	<HR>
	<%
		}
	%>

</body>
</html>
