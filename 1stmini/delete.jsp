<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Car Detail</title>
</head>
<body>
    <h1 style="text-align:center">Delete Car Detail</h1>

    <% 
    if (request.getParameter("delete_car") != null) {
        String carNameToDelete = request.getParameter("car_name_delete");

        try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cars", "root", "ram123");
            Statement stmt = con.createStatement();

            String sql = "DELETE FROM cars_details WHERE LOWER(car_name) = LOWER('" + carNameToDelete + "')";

            int rowsAffected = stmt.executeUpdate(sql);
            
            stmt.close();
            con.close();

            out.print("<p>Deleted " + rowsAffected + " row(s) for car name: " + carNameToDelete + "</p>");
        } catch (Exception ex) {
            out.print("Failed to delete car: " + ex.getMessage());
        }
    }
    %>

    <form method="post" action="delete.jsp">
        <label for="car_name_delete">Enter Car Name to Delete:</label>
        <input type="text" id="car_name_delete" name="car_name_delete">
        <input type="submit" value="Delete Car" name="delete_car">
    </form>

</body>
</html>
