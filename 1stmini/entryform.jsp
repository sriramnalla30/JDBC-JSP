<%@ page import="java.sql.*" %>

<%
try {
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cars", "root", "ram123");
    Statement stmt = con.createStatement();
    
    stmt.executeUpdate("CREATE TABLE IF NOT EXISTS cars_details (car_id INT, car_name VARCHAR(100), car_price INT)");
    
    stmt.close(); 
    con.close(); 
} catch (Exception ex) {
    out.print("Failed to create a table: " + ex.getMessage());
}
%>

<html>
<head>
<title>Cars Details</title>
<link rel="stylesheet" type="text/css" href="styles.css"> 
</head>
<body>
<form>
    <label><input type="button" value="Insert Data" onclick="window.location.href='insert.jsp'"></label><br>
    <label><input type="button" value="View Cars List" onclick="window.location.href='view.jsp'"></label><br>
    <label><input type="button" value="Edit Cars" onclick="window.location.href='edit.jsp'"></label><br>
    <label><input type="button" value="Delete" onclick="window.location.href='delete.jsp'"></label>
</form>
</body>
</html>
