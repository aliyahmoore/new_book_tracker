BookTracker

BookTracker is a full-stack book club management application built with Ruby on Rails and PostgreSQL. Users can create book clubs, add and manage books, track their reading status, and search for new titles using the Google Books API. The app includes full user authentication, custom sorting, and interactive UI features to create a smooth, intuitive experience.

Features
📚 Book & Book Club Management

Create, edit, and manage book clubs.

Add books manually or save books directly from the Google Books API.

Track reading status, genre, notes, start date, and end date.

View all books for each book club and all clubs a book belongs to.

🔍 Google Books API Integration

Search for books using the Google Books API.

View detailed information: title, author, description, and cover image.

Save API-fetched books to your personal list.

🔐 User Authentication

Fully implemented using Devise.

Users can browse and search books without signing in.

Must be signed in to add books or create book clubs.

⚙️ Frontend Enhancements

Custom JavaScript for dynamic search interactions and improved UI responsiveness.

Clean and accessible user interface.

🛠️ Project Planning & Workflow

Planned and organized using Miro, Trello, and Figma.

Continuous updates, refactoring, and feature expansion based on feedback.

🚀 Deployment

Live on Heroku with ongoing improvements and advanced Rails functionality being added over time.

Getting Started
Ruby Version

Ruby 3.x (specify exact version if needed)

System Dependencies

Rails 7.2+

PostgreSQL

Node.js & Yarn (for asset building)

Configuration

Clone the repository:

git clone <your-repo-url>
cd booktracker


Install dependencies:

bundle install
yarn install


Set up environment variables for the Google Books API:

GOOGLE_BOOKS_API_KEY=your_api_key_here

Database Setup
rails db:create
rails db:migrate
rails db:seed   # if applicable

Running the App
rails server


Visit: http://localhost:3000

Testing

If tests are added:

rails test
# or
rspec

Services

Google Books API for external book search.

Deployment Instructions

Ensure environment variables (API key, DB credentials) are set on Heroku.

Push to Heroku:

git push heroku main

Future Improvements

Enhanced book recommendations.

Social features (sharing lists, inviting members).

Improved API caching for faster search results.

User dashboards.