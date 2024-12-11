// Waits for the HTML document to fully load before running the code
document.addEventListener("DOMContentLoaded", () => {
  // Selects the search button from the HTML
  const searchButton = document.querySelector("#searchButton");

  if (searchButton) {
    // Adds a click event listener to the search button
    searchButton.addEventListener("click", () => {
      // Gets the value entered in the search box and trims extra spaces
      const query = document.querySelector("#bookSearch").value.trim();

      // Checks if the search box is empty
      if (!query) {
        alert("Please enter a book name!"); // Alerts the user if no input is provided
        return; // Stops the function from continuing
      }

      // Prepares the Google Books API URL with the search query
      const apiUrl = `https://www.googleapis.com/books/v1/volumes?q=${encodeURIComponent(query)}`;

      // Sends a request to the Google Books API
      fetch(apiUrl)
        .then(response => response.json()) // Converts the API response to JSON format
        .then(data => displayResults(data)) // Passes the data to the displayResults function
        .catch(error => {
          console.error("Error fetching book data:", error); // Logs any error that occurs
          alert("Could not fetch book data. Please try again."); // Alerts the user of an error
        });
    });
  }

  // Function to display search results
  function displayResults(data) {
    // Selects the div where results will be displayed
    const resultsDiv = document.querySelector("#results");
    resultsDiv.innerHTML = ""; // Clears any previous search results

    // Checks if the API returned any books
    if (data.items) {
      // Loops through each book in the results
      data.items.forEach(item => {
        // Extracts the title and authors from the book data
        const title = item.volumeInfo.title || "No title available";
        const authors = item.volumeInfo.authors?.join(", ") || "Unknown author";

        // Creates a div to display each book
        const bookElement = document.createElement("div");
        bookElement.innerHTML = `<h3>${title}</h3><p><strong>Authors:</strong> ${authors}</p>`;
        bookElement.style.cursor = "pointer"; // Changes the cursor to indicate the div is clickable

        // Adds an event listener to show detailed info when the book is clicked
        bookElement.addEventListener("click", () => {
          displayBookPage({ title, authors });
        });

        // Appends the book element to the results div
        resultsDiv.appendChild(bookElement);
      });
    } else {
      // If no books are found, display a message
      resultsDiv.innerHTML = "<p>No results found.</p>";
    }
  }

  // Function to display detailed information about a selected book
  function displayBookPage(book) {
    // Selects the results div to display the book details
    const resultsDiv = document.querySelector("#results");

    // Updates the results div with detailed book information
    resultsDiv.innerHTML = `
      <h2>${book.title}</h2>
      <p><strong>Authors:</strong> ${book.authors}</p>
      <button id="addButton">Add to Book List</button>
      <button id="backButton">Back to Search</button>
    `;

    // Adds an event listener to the "Add to Book List" button
    document.querySelector("#addButton").addEventListener("click", () => addToBookList(book));

    // Adds an event listener to the "Back to Search" button
    document.querySelector("#backButton").addEventListener("click", () => {
      resultsDiv.innerHTML = ""; // Clears the book details view
    });
  }

  // Function to handle adding a book to the user's list
  function addToBookList(book) {
    alert("You must sign in to add books to your list."); // Displays a message for unauthenticated users
  }
});
