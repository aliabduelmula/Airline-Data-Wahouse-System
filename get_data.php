<?php
$servername = "localhost";
$username = "root";
$password = "";

// Create connections
$conn1 = new mysqli($servername, $username, $password, "airline1db");
$conn2 = new mysqli($servername, $username, $password, "airline2db");
$connDW = new mysqli($servername, $username, $password, "airlinedw");

// Check connections
if ($conn1->connect_error) {
    die("Connection failed to Airline1DB: " . $conn1->connect_error);
}
if ($conn2->connect_error) {
    die("Connection failed to Airline2DB: " . $conn2->connect_error);
}
if ($connDW->connect_error) {
    die("Connection failed to Data Warehouse: " . $connDW->connect_error);
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['name'], $_POST['date'], $_POST['totalcost'], $_POST['database'])) {
        $selectedDB = $_POST['database'];
        $name = $_POST['name'];
        $date = $_POST['date'];
        $totalcost = $_POST['totalcost'];

        $conn = ($selectedDB == 'airline1db') ? $conn1 : $conn2;
        $stmt = $conn->prepare("INSERT INTO passengers (Name, Date, Totalcost) VALUES (?, ?, ?)");
        $stmt->bind_param("ssd", $name, $date, $totalcost);

        if ($stmt->execute()) {
            echo "New passenger added successfully to " . htmlspecialchars($selectedDB);
        } else {
            echo "Error adding passenger: " . $stmt->error;
        }
        $stmt->close();
    } else {
        echo "Missing required fields";
    }
} else {
    $view = $_GET['view'] ?? 'all';
    if ($view === 'AirMAC' || $view === 'AirMSC') {
        $sql = "SELECT p.Pid, p.Name, p.Date, p.Totalcost FROM flight_fact f JOIN passenger_dim p ON f.Pid = p.Pid WHERE f.Airline = '$view'";
    } elseif ($view === 'allRoutes') {
        // Using backticks to correctly escape column names that are SQL keywords
        $sql = "SELECT Fid, FNumber, `From`, `To`, Depttime, Arrivtime FROM flights_dim ORDER BY Fid ASC";
        $result = $connDW->query($sql);
        if ($result->num_rows > 0) {
            echo "<table><tr><th>FID</th><th>Flight Number</th><th>From</th><th>To</th><th>Departure Time</th><th>Arrival Time</th></tr>";
            while ($row = $result->fetch_assoc()) {
                echo "<tr><td>" . $row["Fid"] . "</td><td>" . $row["FNumber"] . "</td><td>" . $row["From"] . "</td><td>" . $row["To"] . "</td><td>" . $row["Depttime"] . "</td><td>" . $row["Arrivtime"] . "</td></tr>";
            }
            echo "</table>";
        } else {
            echo "0 results";
        }
        return; // Exit here to avoid running the default case below
    } else {
        $sql = "SELECT * FROM passenger_dim ORDER BY Pid ASC";
    }

    $result = $connDW->query($sql);
    if ($result->num_rows > 0) {
        echo "<table><tr><th>ID</th><th>Name</th><th>Date</th><th>Total Cost</th></tr>";
        while ($row = $result->fetch_assoc()) {
            if (isset($row["Pid"], $row["Name"], $row["Date"], $row["Totalcost"])) {
                echo "<tr><td>" . $row["Pid"] . "</td><td>" . $row["Name"] . "</td><td> " . $row["Date"] . "</td><td> $" . $row["Totalcost"] . "</td></tr>";
            } else {
                echo "<tr><td colspan='4'>Incomplete data</td></tr>"; // Handling missing key scenario
            }
        }
        echo "</table>";
    } else {
        echo "0 results";
    }
}


$conn1->close();
$conn2->close();
$connDW->close();
?>
