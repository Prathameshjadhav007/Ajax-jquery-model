<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ajax</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
$(document).ready(function(){
	alert("ready");
	getAllrecord();
    
	   $('#saveStudent').show();
	   $('#updateStudent').hide();
	   $('#idfield').hide();
	   
	   
	   
	$('#saveStudent').click(function() {
		$.ajax({
		type: "post",
		url: "insertstudent",
		data:{
		name: $("#name").val(),
		age: $("#age").val(), 
		course: $("#course").val()
		},
		success: function(result) {
			getAllrecord();
		$('#studentform')[0].reset() 
		},
		error: function(err) {
			alert("error is" +err)
		}
		});
		});
        });
        
       var data = "";
      
       function getAllrecord() {
         $.ajax({
           type: "GET",
           url: "getallstudent",
           success: function(response) {
           data = response
           $('.tr').remove();
           for (i = 0; i<data.length; i++) {
           $("#studentTable")
                  .append(
                         '<tr class="tr"> <td>'
                         + data[i].id
                         +  '</td> <td>'+ data[i].name  + '</td> <td>'
                         + data[i].age
                         +  '</td> <td>'
                         + data[i].course
                         +  '</td> <td><input type="button" class="btn btn-warning" onclick="editStudent('
                         + data[i].id
                         +  ')" value="Edit"></td> <td> <input type="button" class="btn btn-danger" onclick="deleteStudent('
                         + data[i].id
                         +  ')" value="Delete"></td><td> </tr>');
                        
                      }
                   },
                   error: function(err)  { 
                        alert("error is" + err)
                       }
                    });
                        
   }
       function editStudent(id) {
       	$.ajax({
       	   type: "GET",
       	   url: "getonestudent/" + id,
       	   dataType: "json",
       	   success: function(response) {
       	   //alert("student--"+response.id);
       	   $("#id").val(response.id), 
       	   $("#name").val(response.name), 
       	   $( "#age").val(response.age), 
       	   $("#course").val( response.course)
       	   
       	   $('#saveStudent').hide();
       	   $('#updateStudent').show();
       	   $('#idfield').show();
       	   },
       	   error: function(err) {
       	   alert("error is" + err)
       	   }
       	   });
         }
         
         function updatestudentbtn() {	
       	  $.ajax({
       	  type: "POST",
       	  url: "updatestudent",
       	  data: {
       	  id: $("#id").val(), 
       	  name: $("#name").val(), 
       	  age: $("#age").val(), 
       	  course: $("#course").val()
       	  },
       	  success: function(result) { 
       	   getAllrecord();
       	  $('#saveStudent').show();
       	  $('#updateStudent').hide();
       	  $('#idfield').hide();
          $('#studentform')[0].reset()
       	  },
       	  error: function(err) { 
       		  alert("error is" + err)
       	  }
       	  });
       	  }
         
         function deleteStudent(id) {
       	  $.ajax({
       	  type: "get",	  
       	  url: "deleteStudent2/" + id,
       	  success: function(response) {
       		getAllrecord();
       	  },
       	  error: function(err) {
       	  alert("error is" + err)
       	  }
       	  });
         }
        /*  function cheaking(){
             $.ajax({
             type: "get",	  
          	  url: "cheaking",
          	  success: function(response) { 
          		alert(response);
          		
              $('#red').show();
              $('#orange').hide();
          	  }
         }); 
        } */
         function favouriteadd(id){
              $.ajax({
              type: "get",	  
           	  url: "favourite/" +id,
           	  success: function(response) { 
           		alert(response);
               $('#red').show();
               $('#orange').hide();
           	  }
          }); 
         }
         function favouritedelete(id){
             $.ajax({
             type: "get",	  
          	  url: "favourite2/" +id,
          	  success: function(response) { 
          	   alert(response);
              $('#red').hide();
              $('#orange').show();
          	  }
         }); 
        }
         
         
</script>
</head>
<body>
 <nav class="navbar navbar-dark bg-dark">
    <h3 style="color:white;">Student Management Crud Ajax</h3>
</nav>
<br> <button id="getTime">time</button>
<div  id="printTime"></div>
<div class="container">
    <div class="row">
        <div class="col-sm-4">
            <form id="studentform" name="studentform">
                
               
                <div class="form-group" id="idfield" align="left">
                    <label for="id">Student id</label>
                    <input type="text" id="id" name="id"  class="form-control" readonly="readonly">
                </div>
               

                <div class="form-group" align="left">
                    <label for="name">Student Name</label>
                    <input type="text" id="name" name="name" placeholder="Student Name" class="form-control" required>
                </div>

                <div class="form-group" align="left">
                    <label for="age">Age</label>
                    <input type="text" id="age" name="age" placeholder="age" class="form-control" required>
                </div>

                <div class="form-group" align="left">
                    <label>course</label>
                    <input type="text" id="course" name="course" placeholder="fee" class="form-control" required>
                </div>

                <div class="form-group" align="left">
                    <button type="button" class="btn btn-success" id="saveStudent" >sAdd</button>
                  <!--    <button type="button" class="btn" style="background-color:red;"  id="red" onclick="favourite1()" >red</button>
                     <button type="button" class="btn" style="background-color:orange;" id="orange" onclick="favourite2()">Orange</button>
                    --> <button type="button" class="btn btn-warning" id="updateStudent" onclick="updatestudentbtn()">Update</button>           
                </div>
            </form>
        </div>

        <div class="col-sm-8">
            <div class="panel-body">
                <table  class="table table-bordered" cellpadding="0" cellspacing="0" width="100%">
                    <thead>
                    <tr>
                    <th>ID</th>
                    <th scope="col">Student Name</th>
                    <th>age</th>
                    <th>course</th>
                    <th>Edit</th>
                    <th>Delete</th>
                    </tr>
                    </thead>
                   <tbody id="studentTable">
                     <%-- <c:forEach var="std" items="${student}">
                    <tr>
                    <td class="table-plus">${std.id}</td>
                    <td >${std.name}</td>
                    <td >${std.age}</td>
                    <td >${std.course}</td>
                    <td ><a href="editEmployee/${std.id}" class="btn btn warning"></a>Edit</td>
                    <td ><a href="deleteEmployee/${std.id}" class="btn btn danger"></a>Delete</td>
                    </tr>
                    </c:forEach> --%>
                    </tbody>
                </table>

            </div>

        </div>


    </div>

</div>
 
</body>
</html>