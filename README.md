# Persian ANPR UI (Flutter)

This project is a **Flutter-based UI** for a Persian **Automatic Number Plate Recognition (ANPR)** system. It supports **Web and Windows** platforms, leveraging modern technologies for state management, database handling, and backend integration.

## Features

- **Flutter UI** for an intuitive and smooth user experience.
- **Multi-platform support**: Runs on **Web and Windows**.
- **GetX for state management**, ensuring efficient and reactive UI updates.
- **PocketBase** as the database backend (schema available).
- **YOLO for license plate detection** in the backend.
- **Uvicorn for backend connectivity**, enabling seamless front-to-back communication.

## Installation

### Prerequisites

Ensure you have the following installed:

- **Flutter** (latest stable version)
- **PocketBase** (for the database)
- **Python** (for backend services)
- **Uvicorn** (FastAPI ASGI server)
- **YOLO** (for number plate detection)

### Steps

1. **Clone the repository:**

   ```sh
   git clone <repo_url>
   cd <repo_name>
   ```

2. **Install Flutter dependencies:**

   ```sh
   flutter pub get
   ```

3. **Run PocketBase:**

   ```sh
   ./pocketbase serve
   ```

4. **Start the backend (YOLO & Uvicorn):**

   ```sh
   uvicorn main:app --host 0.0.0.0 --port 8000
   ```

5. **Run the Flutter app:**

   ```sh
   flutter run -d chrome  # For web
   flutter run -d windows  # For Windows
   ```

## Usage

Once the application is running, it will communicate with the backend for **real-time license plate detection** and database storage using **PocketBase**.

## PocketBase Schema

The PocketBase schema is available in the repo. Ensure you import it before running the database server.

## Contributing

Feel free to fork this repository and submit pull requests to improve or extend the project.

## License

This project is open-source and available under the **MIT License**.

---

💡 **For any issues or feature requests, feel free to open an issue on GitHub.**



