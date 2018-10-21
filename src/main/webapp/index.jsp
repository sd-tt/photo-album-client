<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/dropzone.css">
    <script src="js/jquery-3.3.1.js"></script>
    <script src="js/dropzone.js"></script>
    <script src="http://localhost:8080/auth/js/keycloak.js"></script>
    <script>
        var apiUrl = "http://localhost:5001/api";
        var uploadUrl = apiUrl + "/upload";
        var usersUrl = apiUrl + "/users";
        Dropzone.autoDiscover = false;
        $(document).ready(function () {
            var keycloak = Keycloak('keycloak.json');
            keycloak.init({ onLoad: "login-required" }).success(function () {

                $.ajax({
                    url: usersUrl,
                    method: "GET",
                    dataType: "json",
                    mimeType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader("Authorization", "Bearer " + keycloak.token);
                    },
                    success: function (users) {
                        $.each(users, function (index, user) {
                            var dropzone = $('<div><p>' + user.id + '</p><div id="upload-' + user.id + '" class="dropzone"></div></div>');
                            $("#customers").append(dropzone);
                            console.log(uploadUrl + "/" + user.id);
                            $("#upload-" + user.id).dropzone({
                                url: uploadUrl + "/" + user.id,
                                uploadMultiple: true,
                                parallelUploads: 5,
                                acceptedFiles: "image/*",
                                dataType: "image",
                                headers: {
                                    "Authorization": "Bearer " + keycloak.token
                                }
                            });
                        });
                    }
                });
            });
        });
    </script>
</head>

<body>
    <main>
        <section>
            <h1 id="try-it-out">Customers</h1>
            <div id="customers"></div>
        </section>
    </main>
</body>

</html>