# 📚 Pegawai Dosen App

A simple yet effective Flutter application designed for managing lecturer (Dosen) data, featuring full Create, Read, Update, and Delete (CRUD) functionalities. This app integrates with a custom backend API to provide a seamless data management experience.

## ✨ Features

- **Splash Screen**: A visually appealing introductory screen upon app launch
- **Dosen List Page**: View a comprehensive list of all registered lecturers
- **Add Dosen Page**: Easily add new lecturer entries with detailed information
- **Dosen Detail Page**: View individual lecturer details, with options to Update existing information or Delete the entry
- **Form Validation**: Ensures data integrity during input
- **API Integration**: Communicates with a RESTful API for data persistence
- **Responsive UI**: Designed to look good on various screen sizes

## 📸 Screenshots & Demo

[Add screenshots or a GIF of your application here]

## 🛠️ Technologies Used

- **Flutter**: UI toolkit for building natively compiled applications
- **Dart**: Programming language used by Flutter
- **http package**: For making network requests to the backend API

## 🚀 Getting Started

### Prerequisites

- Flutter SDK installed
- A running backend API that exposes the `/api/dosen` endpoint
- [Optional] VS Code with Flutter and Dart plugins, or Android Studio

### Installation

1. Clone the repository:
```bash
git clone https://github.com/YOUR_USERNAME/pegawaidosenapp.git
cd pegawaidosenapp
```

2. Install dependencies:
```bash
flutter pub get
```

## API Integration

This application expects a backend API running at `http://10.126.193.85:8000/api/dosen` that supports standard RESTful operations.

### Expected JSON structure for a Dosen object:

```json
{
    "no": 1,
    "nip": "12",
    "nama_lengkap": "nano",
    "no_telepon": "12092352231",
    "email": "atomm@gmail.com",
    "alamat": "adfsklewrpodfwerw",
    "created_at": "2025-06-13T02:46:48.000000Z",
    "updated_at": "2025-06-13T02:46:48.000000Z"
}
```

### Important: Adjusting the Base URL

Modify the `_baseUrl` variable in `lib/services/api_service.dart`:

```dart
class ApiService {
    static const String _baseUrl = 'http://YOUR_BACKEND_IP_OR_HOSTNAME:8000/api/dosen';
    // ...
}
```

- For Android Emulators: use `10.0.2.2`
- For iOS Simulators or Web: use `localhost`
- For Physical devices: use your machine's IP address

## Running the App

```bash
flutter run
```

## 📂 Project Structure

```
pegawaidosenapp/
├── lib/
│   ├── main.dart                 # Main application entry point
│   ├── models/
│   │   └── dosen_model.dart      # Data model for Dosen
│   ├── services/
│   │   └── api_service.dart      # API interactions
│   └── screens/
│       ├── splash_screen.dart    # Initial splash screen
│       ├── dosen_list_page.dart  # List of lecturers
│       ├── add_dosen_page.dart   # Add new lecturer form
│       └── dosen_detail_page.dart# Lecturer details page
├── pubspec.yaml
├── README.md
└── pegawai_dosen.sql
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📧 Contact

- GitHub: [@AtomNano](https://github.com/AtomNano)
- Email: luthfi2264a@gmail.com