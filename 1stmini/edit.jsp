<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Car Detail</title>
</head>
<body>
<h1 style="text-align:center">Edit Car Detail</h1>

<%
    String carNameNew = request.getParameter("car_name_new");
    String newPriceStr = request.getParameter("edit_price");

    if (carNameNew != null && newPriceStr != null) {
        try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cars", "root", "ram123");
            Statement stmt = con.createStatement();
            int newPrice = Integer.parseInt(newPriceStr);

            String updateQuery = "UPDATE cars_details SET car_price=" + newPrice + " WHERE LOWER(car_name)=LOWER('" + carNameNew + "')";
            int rowsAffected = stmt.executeUpdate(updateQuery);

            if (rowsAffected > 0) {
                out.print("Car price updated successfully.");
            } else {
                out.print("Failed to update car price. Car name not found.");
            }

            stmt.close();
            con.close();
        } catch (Exception ex) {
            out.print("Error: " + ex.getMessage());
        }
    }
%>

<%
try {
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cars", "root", "ram123");
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT car_name FROM cars_details");
%>

<form method="post" action="">
    <label for="car_name">Select Car Name:</label>
    <select name="car_name_new" id="car_name">
<%
    while (rs.next()) {
%>
        <option value="<%= rs.getString("car_name") %>"><%= rs.getString("car_name") %></option>
<%
    }
%>
    </select>
    <br><br>
    <label for="edit_price">Enter New Price:</label>
    <input type="text" name="edit_price" id="edit_price" required>
    <br><br>
    <input type="submit" value="Edit Car">
</form>

<%
    rs.close();
    stmt.close();
    con.close();
} catch (Exception ex) {
    out.print("Failed to retrieve car names: " + ex.getMessage());
}
%>

</body>
</html>
