<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<body>
<form method="post" action="view.jsp"> 
    <label><input type="submit" value="List All" name="list_all"></label><br><br> 

    <label><input type="submit" value="List with ID or NAME or PRICE" name="list_select"></label><br><br> 
    <% if (request.getParameter("list_select") != null) { %>
        <label>Enter Car Name or Price to search: <input type="text" name="select_with"></label>
        <label><input type="submit" value="Search" name="search_button"></label>
    <% } %>
</form>

<% 
if (request.getParameter("list_all") != null) { 
    try {
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cars", "root", "ram123");
        Statement stmt = con.createStatement();        
        ResultSet rs = stmt.executeQuery("SELECT * FROM cars_details"); 
%>
<table border="1"> 
<tr>
    <th>Car ID</th>
    <th>Car Name</th>
    <th>Car Price</th>
</tr>
<%
        while (rs.next()) { 
%>
<tr>
    <td><%= rs.getInt("car_id") %></td>
    <td><%= rs.getString("car_name") %></td>
    <td><%= rs.getInt("car_price") %></td>        
</tr>
<%
        }
        rs.close();
        stmt.close(); 
        con.close();  
    } catch(Exception ex) { 
        out.print("Failed to retrieve all data: " + ex.getMessage());
    }
}
%>
</table>

<%
if (request.getParameter("search_button") != null) {
    String search = request.getParameter("select_with");
    boolean isNumeric = search.chars().allMatch(Character::isDigit);
%>
<table border="1">
<tr>
    <th>Car ID</th>
    <th>Car Name</th>
    <th>Car Price</th>
</tr>
<%
    try {
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cars", "root", "ram123");
        Statement stmt = con.createStatement();        
        ResultSet rs = stmt.executeQuery("SELECT * FROM cars_details");
        boolean match = false;
        while (rs.next()) {
            if (isNumeric && search.equals(String.valueOf(rs.getInt("car_id")))) {
                match = true;
%>
<tr>
    <td><%= rs.getInt("car_id") %></td>
    <td><%= rs.getString("car_name") %></td>
    <td><%= rs.getInt("car_price") %></td>
</tr>
<%
            } else if (isNumeric && search.equals(String.valueOf(rs.getInt("car_price")))) {
                match = true;
%>
<tr>
    <td><%= rs.getInt("car_id") %></td>
    <td><%= rs.getString("car_name") %></td>
    <td><%= rs.getInt("car_price") %></td>
</tr>
<%
            } else if (!isNumeric && search.equalsIgnoreCase(rs.getString("car_name"))) {
                match = true;
%>
<tr>
    <td><%= rs.getInt("car_id") %></td>
    <td><%= rs.getString("car_name") %></td>
    <td><%= rs.getInt("car_price") %></td>
</tr>
<%
            }
        }
        if (!match) {
%>
<tr>
    <td colspan="3">No data</td>
</tr>
<%
        }
        rs.close();
        stmt.close(); 
        con.close();  
    } catch (Exception ex) {
        out.print("Failed to retrieve data: " + ex.getMessage());
    }
}
%>
</table>

</body>
</html>
