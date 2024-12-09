document.addEventListener("DOMContentLoaded", () => {
    const searchButton = document.querySelector("#searchButton");
    
    if (searchButton) {
      searchButton.addEventListener("click", async () => {
        const query = document.querySelector("#bookSearch").value.trim();
        
        if (!query) {
          alert("Please enter a book name!");
          return;
        }
  
        // Make a Google Books API request
        const apiKey = "AIzaSyBl02p05boEJBalaIk4vhvhYsQziBUSUyA";
        const apiUrl = `https://www.googleapis.com/books/v1/volumes?q=${encodeURIComponent(query)}&key=${apiKey}`;
  
        try {
          const response = await fetch(apiUrl);
          const data = await response.json();
          displayResults(data);
        } catch (error) {
          console.error("Error fetching book data:", error);
          alert("Could not fetch book data. Please try again.");
        }
      });
    }
  
    function displayResults(data) {
      const resultsDiv = document.querySelector("#results");
      resultsDiv.innerHTML = ""; // Clear previous results
  
      if (data.items) {
        data.items.forEach(item => {
          const title = item.volumeInfo.title || "No title available";
          const authors = item.volumeInfo.authors?.join(", ") || "Unknown author";
          
          const bookElement = document.createElement("div");
          bookElement.innerHTML = `
            <h3>${title}</h3>
            <p><strong>Authors:</strong> ${authors}</p>
          `;
          resultsDiv.appendChild(bookElement);
        });
      } else {
        resultsDiv.innerHTML = "<p>No results found.</p>";
      }
    }
  });
  