**Property Management System**
==============================

This is a Property Management System that allows users to manage properties with features such as adding, editing, and deleting properties. It is built with a Flutter frontend and a Laravel backend.

* * * * *

**Features**
------------

-   Add, Edit, Delete, and View Properties.
-   Search functionality and Pagination for properties.
-   Property status (Active, Inactive, Pending).
-   Secure API integration using Laravel Sanctum.
-   User authentication (Login and Registration).

* * * * *

**Screenshots**
---------------

### Dashboard Example

Below is an example of the dashboard:

![Dashboard Example](assets/image.png)



* * * * *

**Installation Instructions**
-----------------------------

### **Prerequisites**

Ensure you have the following installed:

-   PHP >= 8.0
-   Composer
-   Node.js & npm
-   Flutter SDK
-   MySQL or any compatible database
-   Laravel CLI
-   A browser for testing (e.g., Google Chrome for Flutter web development)

* * * * *

### **Step 1: Backend Setup**

1.  Clone the repository:

    bash

    Copy code

    `git clone <repository-url>
    cd <repository-backend-folder>`

2.  Install backend dependencies:

    bash

    Copy code

    `composer install`

3.  Set up environment variables: Copy the `.env.example` file to `.env` and edit it with your database credentials:

    bash

    Copy code

    `cp .env.example .env`

    Update `.env`:

    makefile

    Copy code

    `DB_CONNECTION=mysql
    DB_HOST=127.0.0.1
    DB_PORT=3306
    DB_DATABASE=your_database_name
    DB_USERNAME=your_database_user
    DB_PASSWORD=your_database_password`

4.  Generate an application key:

    bash

    Copy code

    `php artisan key:generate`

5.  Run database migrations:

    bash

    Copy code

    `php artisan migrate`

6.  Seed the database with sample data (optional):

    bash

    Copy code

    `php artisan db:seed`

7.  Serve the Laravel application:

    bash

    Copy code

    `php artisan serve`

    By default, it runs at `http://127.0.0.1:8000`.

* * * * *

### **Step 2: Frontend Setup**

1.  Navigate to the frontend folder:

    bash

    Copy code

    `cd <repository-frontend-folder>`

2.  Install Flutter dependencies:

    bash

    Copy code

    `flutter pub get`

3.  Configure the API URL: Update the `baseUrl` in the API service file (e.g., `lib/services/api_service.dart`) to match your backend URL:

    dart

    Copy code

    `static const String baseUrl = "http://127.0.0.1:8000/api";`

4.  Run the application in the browser:

    bash

    Copy code

    `flutter run -d chrome`

    Alternatively, you can run on other devices:

    bash

    Copy code

    `flutter devices   # Lists connected devices
    flutter run -d <device-id>`

* * * * *

### **Step 3: API Authentication with Sanctum**

To secure API requests:

1.  Login or Register via the frontend.
2.  Use the Bearer token received during login to access authenticated routes.

* * * * *

### **Project Structure**

#### **Backend (Laravel)**:

-   **`routes/api.php`**: Defines API routes.
-   **`app/Http/Controllers`**: Contains controller logic for API endpoints.
-   **`app/Models`**: Contains the data models (e.g., `Property`).
-   **`database/migrations`**: Includes database structure definitions.

#### **Frontend (Flutter)**:

-   **`lib/screens`**: Contains UI components and screens (e.g., `PropertyScreen`).
-   **`lib/services`**: Contains API service logic.
-   **`lib/dialogs`**: Contains reusable dialog components (e.g., Add/Edit Property).

* * * * *

**Tech Stack**
--------------

-   **Backend**: Laravel 10.x, Sanctum
-   **Frontend**: Flutter 3.x
-   **Database**: MySQL

* * * * *

**Contribution Guidelines**
---------------------------

1.  Fork the repository.
2.  Create a new branch:

    bash

    Copy code

    `git checkout -b feature-name`

3.  Commit your changes:

    bash

    Copy code

    `git commit -m "Add feature-name"`

4.  Push to your branch:

    bash

    Copy code

    `git push origin feature-name`

5.  Open a Pull Request.

* * * * *

**License**
-----------

This project is open-source and available under the MIT License.

* * * * *

### Notes:

-   Replace `<repository-url>` with the actual repository URL.
-   Replace `<repository-backend-folder>` and `<repository-frontend-folder>` with the correct folder names for backend and frontend.

happy coding# property-management
