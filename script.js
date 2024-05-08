// JavaScript to load data based on navigation
function loadData(view, date='') {
    console.log("Loading data for view:", view); // Debugging output
    let url = 'get_data.php?view=' + view + '&_ts=' + new Date().getTime();
    if (date !== '') {
        url += '&date=' + date;
    }
    
    fetch(url)
    .then(response => response.text())
    .then(html => {
        console.log("Data received:", html); // Debugging output
        document.getElementById('dataDisplay').innerHTML = html;
    })
    .catch(error => console.error('Error loading the data:', error));
}

document.getElementById('newPassenger').addEventListener('submit', function(event) {
    event.preventDefault();
    const formData = new FormData(this);

    // Log each form field
    for (let [key, value] of formData.entries()) {
        console.log(`${key}: ${value}`);
    }

    // Send the form data
    fetch('get_data.php', {
        method: 'POST',
        body: formData
    })
    .then(response => response.text())
    .then(response => {
        alert(response);
        loadData('all'); // Optionally reload the displayed data
    })
    .catch(error => console.error('Error adding passenger:', error));
});


