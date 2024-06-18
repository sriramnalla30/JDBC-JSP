<%@ page import="java.sql.*" %>
<html>
<head>
</head>
<body>
<form method="post" action="insert.jsp">
    <label>Car Id: <input type="text" name="car_id"></label><br><br>
    <label>Car Name: <input type="text" name="car_name"></label><br><br>
    <label>Car Price: <input type="text" name="car_price"></label><br><br>
    <input type="submit" value="Submit">
</form>

<%
if (request.getParameter("car_id") != null && request.getParameter("car_name") != null && request.getParameter("car_price") != null) {
    try {
        int car_id = Integer.parseInt(request.getParameter("car_id"));
        String car_name = request.getParameter("car_name");
        int car_price = Integer.parseInt(request.getParameter("car_price"));
        
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cars", "root", "ram123");
        Statement stmt = con.createStatement();
        
        stmt.executeUpdate("INSERT INTO cars_details VALUES (" + car_id + ", '" + car_name + "', " + car_price + ")");
        
        stmt.close();
        con.close();
        out.print("Data inserted successfully.");
    } catch (NumberFormatException e) {
        out.print("Invalid input. Please enter valid numbers for Car Id and Car Price.");
    } catch (SQLException e) {
        out.print("SQL Exception: " + e.getMessage());
    } catch (Exception e) {
        out.print("Exception: " + e.getMessage());
    }
}
%>

</body>
</html>
