<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Insert Student Record</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f4f8;
            margin: 0;
            padding: 40px;
            text-align: center;
        }

        h2 {
            color: #333;
        }

        form {
            background-color: #fff;
            padding: 25px;
            margin: 20px auto;
            width: 350px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        input[type="text"], input[type="submit"] {
            width: 90%;
            padding: 10px;
            margin: 10px 0;
            font-size: 16px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
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

        .message {
            color: green;
            font-weight: bold;
        }

        .error {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>

<h2>Insert Student Record</h2>
<form method="post">
    <input type="text" name="stud_id" placeholder="Student ID" required>
    <input type="text" name="name" placeholder="Name" required>
    <input type="text" name="class" placeholder="Class" required>
    <input type="text" name="division" placeholder="Division" required>
    <input type="text" name="city" placeholder="City" required>
    <input type="submit" value="Insert">
</form>
<a href="view.jsp">View All Students</a>

<%
    // Only execute DB code if form is submitted
    String stud_id = request.getParameter("stud_id");
    String name = request.getParameter("name");
    String className = request.getParameter("class"); // class is a keyword, so use className
    String division = request.getParameter("division");
    String city = request.getParameter("city");

    if (stud_id != null && name != null && className != null && division != null && city != null) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/maharashtra", "root", "");

            PreparedStatement ps = con.prepareStatement("INSERT INTO student_info (Stud_id, Name, Class, Division, City) VALUES (?, ?, ?, ?, ?)");
            ps.setInt(1, Integer.parseInt(stud_id));
            ps.setString(2, name);
            ps.setString(3, className);
            ps.setString(4, division);
            ps.setString(5, city);
            ps.executeUpdate();
            out.println("<p class='message'>Record inserted successfully!</p>");

            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM student_info");
%>

<h2>Student Information</h2>
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
        <a href="edit.jsp">Edit or Delete Students</a>

    </tr>
<%
            }
            con.close();
        } catch(Exception e) {
            out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
        }
    }
%>

</table>
</body>
</html>
