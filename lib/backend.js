<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <style>
        /* Same as before */
    </style>
</head>
<body>

    <div class="header">
        <h1>Admin Dashboard</h1>
    </div>

    <div class="sidebar">
        <h3>Menu</h3>
        <div class="menu-item" onclick="showSection('students')">Manage Students</div>
        <div class="menu-item" onclick="showSection('teachers')">Manage Teachers</div>
        <div class="menu-item" onclick="showSection('courses')">Manage Courses</div>
        <div class="menu-item" onclick="showSection('reports')">Generate Reports</div>
    </div>

    <div class="content">
        <div id="students-section">
            <h2>Manage Students</h2>
            <button onclick="addStudent()">Add New Student</button>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Address</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="students-list">
                    <!-- Students will be dynamically added here -->
                </tbody>
            </table>
        </div>
    </div>

    <script>
        // Fetch students from the backend
        function fetchStudents() {
            fetch('http://localhost:5000/students')
                .then(response => response.json())
                .then(data => {
                    const studentList = document.getElementById('students-list');
                    studentList.innerHTML = ''; // Clear existing content
                    data.forEach(student => {
                        const row = document.createElement('tr');
                        row.innerHTML = `
                            <td>${student.student_id}</td>
                            <td>${student.name}</td>
                            <td>${student.address}</td>
                            <td>
                                <button onclick="editStudent(${student.student_id})">Edit</button>
                                <button onclick="deleteStudent(${student.student_id})">Delete</button>
                            </td>
                        `;
                        studentList.appendChild(row);
                    });
                });
        }

        function addStudent() {
            alert("This is where the 'Add Student' form would open.");
        }

        function editStudent(id) {
            alert('Edit student with ID: ' + id);
        }

        function deleteStudent(id) {
            fetch(`http://localhost:5000/students/${id}`, { method: 'DELETE' })
                .then(response => response.json())
                .then(data => {
                    alert(data.message);
                    fetchStudents(); // Refresh the list after deletion
                });
        }

        fetchStudents(); // Load students when the page loads
    </script>

</body>
</html>
