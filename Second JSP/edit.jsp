<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit or Delete Student Records</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f4f8;
            padding: 40px;
            text-align: center;
        }

        table {
            margin: 20px auto;
            border-collapse: collapse;
            width: 90%;
        }

        th, td {
            padding: 12px 16px;
            border: 1px solid #ccc;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        form {
            display: inline;
        }

        input[type="submit"], button {
            padding: 5px 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 4px;
        }

        .delete-btn {
            background-color: #e74c3c;
        }

        h2 {
            color: #333;
        }

        a {
            text-decoration: none;
            color: #4CAF50;
        }
    </style>
</head>
<body>

<h2>Edit or Delete Student Records</h2>

<%
    String action = request.getParameter("action");
    String studIdParam = request.getParameter("stud_id");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/maharashtra", "root", "");

        // Handle Delete
        if ("delete".equals(action) && studIdParam != null) {
            PreparedStatement ps = con.prepareStatement("DELETE FROM student_info WHERE Stud_id = ?");
            ps.setInt(1, Integer.parseInt(studIdParam));
            ps.executeUpdate();
            out.println("<p style='color:green;'>Record deleted successfully!</p>");
        }

        // Handle Update
        if ("update".equals(action) && studIdParam != null) {
            String name = request.getParameter("name");
            String className = request.getParameter("class");
            String division = request.getParameter("division");
            String city = request.getParameter("city");

            PreparedStatement ps = con.prepareStatement(
                "UPDATE student_info SET Name=?, Class=?, Division=?, City=? WHERE Stud_id=?"
            );
            ps.setString(1, name);
            ps.setString(2, className);
            ps.setString(3, division);
            ps.setString(4, city);
            ps.setInt(5, Integer.parseInt(studIdParam));
            ps.executeUpdate();
            out.println("<p style='color:green;'>Record updated successfully!</p>");
        }

        // Display Table
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM student_info");
%>

<table>
    <tr>
        <th>Stud ID</th>
        <th>Name</th>
        <th>Class</th>
        <th>Division</th>
        <th>City</th>
        <th>Actions</th>
    </tr>

<%
        while (rs.next()) {
%>
    <tr>
        <form method="post" action="edit.jsp">
            <td><%= rs.getInt("Stud_id") %></td>
            <td><input type="text" name="name" value="<%= rs.getString("Name") %>" required></td>
            <td><input type="text" name="class" value="<%= rs.getString("Class") %>" required></td>
            <td><input type="text" name="division" value="<%= rs.getString("Division") %>" required></td>
            <td><input type="text" name="city" value="<%= rs.getString("City") %>" required></td>
            <td>
                <input type="hidden" name="stud_id" value="<%= rs.getInt("Stud_id") %>">
                <input type="hidden" name="action" value="update">
                <input type="submit" value="Update">
        </form>
        <form method="post" action="edit.jsp" style="display:inline;">
            <input type="hidden" name="stud_id" value="<%= rs.getInt("Stud_id") %>">
            <input type="hidden" name="action" value="delete">
            <input type="submit" class="delete-btn" value="Delete">
        </form>
            </td>
    </tr>
<%
        }
        con.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
%>
</table>

<a href="index.jsp">← Back to Insert Page</a>

</body>
</html>
