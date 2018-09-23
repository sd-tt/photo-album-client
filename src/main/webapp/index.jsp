<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<span class="admin-access">Admin access</span>
<span class="user-access">User access</span>
<span>All access</span>
<script src="http://localhost:8080/auth/js/keycloak.js"></script>
<script>
    window.onload = function () {
        var keycloak = Keycloak('keycloak.json');
        keycloak.init({onLoad: "login-required"}).success(function () {
            alert("Success!");
        });
    };
</script>
</body>
</html>
