<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Student Records</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f4f8;
            padding: 40px;
            text-align: center;
        }

        table {
            margin: 40px auto;
            border-collapse: collapse;
            width: 80%;
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

        h2 {
            color: #333;
        }

        a {
            display: inline-block;
            margin-top: 20px;
            color: #4CAF50;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<h2>All Student Records</h2>

<%
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/maharashtra", "root", "");
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM student_info");
%>

<table>
    <tr><th>Stud ID</th><th>Name</th><th>Class</th><th>Division</th><th>City</th><th>Action</th></tr>

<%
        while (rs.next()) {
%>
    <tr>
        <td><%= rs.getInt("Stud_id") %></td>
        <td><%= rs.getString("Name") %></td>
        <td><%= rs.getString("Class") %></td>
        <td><%= rs.getString("Division") %></td>
        <td><%= rs.getString("City") %></td>
        <td><a href="edit.jsp?stud_id=<%= rs.getInt("Stud_id") %>">Edit</a></td>

    </tr>
<%
        }
        con.close();
    } catch(Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
%>
</table>

<a href="index.jsp">← Back to Insert Page</a>

</body>
</html>
