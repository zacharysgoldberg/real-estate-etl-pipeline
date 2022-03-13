Emergeny Calls

| Description |
| ----------- |

A backend project that updates users on emergencies/incidents, similar to Citizen. However, users are able to submit tips relating to emergencies/incidents as well as upload related video, image, and sound content.

The project began as a simple database to store and manipulate 911 emergency call data sets. After ataining a deeper understanding of ORM and endpoint paths, I decided to include a tips feature that can include the personal info of the user submitting the tip or to remain anonymous. This addittion inherently changes the results of the data sets and adds more nuances to the details surounding them.

| Design |
| ------ |

I chose to use an ORM approach in this project to not only get more practice with it but because this project does not inlcude any significant amount of numerical data. Thus, raw SQL is not necessary to achieve the desired results that this project is aiming for.

Currently, this project only contains fake data. Data is manipulated significantly during the population phase to add authenticity.

Future improvements include a friendly UI, the ability to upload real content and real data sets, and better user account sign up / login features.

| API ENDPOINTS: |
| -------------- |

| Endpoints, Users                    | Methods    | Parameters          | Action                          |
| ----------------------------------- | ---------- | ------------------- | ------------------------------- |
| /users                              | GET        | None                | List all users                  |
| /users/int:id                       | GET        | user.id             | List a user                     |
| /users/int:id/tips_submitted        | GET        | user.id             | List tips submitted by a user   |
| /users/int:id/liked_content         | GET        | user.id             | List content that as user liked |
| /users                              | POST       | None                | Creates a new user              |
| /users/int:id/like                  | POST       | user.id             | Like content by a user          |
| /users/int:id                       | PATCH, PUT | user.id             | Update user info                |
| /users/int:id                       | DELETE     | user.id             | Delete a user                   |
| /users/int:id/unlike/int:content_id | DELETE     | user.id, content.id | Unlike content by a user        |

| Endpoints, Tips             | Methods | Parameters | Action                         |
| --------------------------- | ------- | ---------- | ------------------------------ |
| /tips                       | GET     | None       | List all tips                  |
| /tips/int:id                | GET     | tip.id     | List a tip                     |
| /tips/int:id/submitted_tips | GET     | tip.id     | List user that submitted a tip |
| /tips                       | POST    | None       | Create/Submit a new tip        |
| /tips/int:id                | DELETE  | user.id    | Delete a tip                   |

| Endpoints, Content           | Methods    | Parameters | Action                               |
| ---------------------------- | ---------- | ---------- | ------------------------------------ |
| /content                     | GET        | None       | List all content                     |
| /content/int:id              | GET        | content.id | List a content post                  |
| /content/int:id/users_liking | GET        | content.id | List users that liked a content post |
| /content                     | POST       | None       | Create a new content post            |
| /content/int:id              | PATCH, PUT | content.id | Update a content post                |
| /content/int:id              | DELETE     | content.id | Delete a content post                |

| Endpoints, Incidents | Methods | Parameters  | Action             |
| -------------------- | ------- | ----------- | ------------------ |
| /incidents           | GET     | None        | List all incidents |
| /incidents/int:id    | GET     | incident.id | List an incident   |

| Endpoints, Locations | Methods | Parameters  | Action             |
| -------------------- | ------- | ----------- | ------------------ |
| /locations           | GET     | None        | List all locations |
| /locations/int:id    | GET     | location.id | List a location    |
