<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@page import="java.sql.*" %>
<jsp:useBean id="connection" class="lab.MyConnection" scope="application"/>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Show</title>
    </head>
    <body>
        <%
            String sid = request.getParameter("sid");
            if (sid == null || sid.trim().length() == 0) {
                sid = request.getParameter("id");
            }

            if (sid == null || sid.trim().length() == 0) {
                out.println("Student not found");
            } else {
                try {
                    PreparedStatement p1 = connection.statement(
                            "select name, address from student where id = ?");
                    if (p1 != null) {
                        p1.setString(1, sid.trim());
                        ResultSet re1 = p1.executeQuery();

                        if (re1.next()) {
                            String name = re1.getString("name");
                            String address = re1.getString("address");
        %>
        Name: <%= name %><br/>
        Address: <%= address %><br/>

        <table border="1">
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Year</th>
                <th>Score</th>
            </tr>
        <%
                            PreparedStatement p2 = connection.statement(
                                    "select id, title, yearofstudy, score "
                                    + "from course, study "
                                    + "where id = courseid and studentid = ?");
                            if (p2 != null) {
                                p2.setString(1, sid.trim());
                                ResultSet re2 = p2.executeQuery();

                                while (re2.next()) {
        %>
            <tr>
                <td><%= re2.getString("id") %></td>
                <td><%= re2.getString("title") %></td>
                <td><%= re2.getString("yearofstudy") %></td>
                <td><%= re2.getFloat("score") %></td>
            </tr>
        <%
                                }
                            }
        %>
        </table>
        <%
                        } else {
                            out.println("Student not found");
                        }
                    } else {
                        out.println("Database connection error.");
                    }
                } catch (Exception e) {
                    out.println("An error occurred: " + e.getMessage());
                }
            }
        %>
    </body>
</html>
