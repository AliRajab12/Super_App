# 🚀 Super App

A multi-service Flutter super app inspired by Careem — bringing food delivery, visa services, salon bookings, pharmacy, and more into a single seamless experience.

> **Status:** UI Complete · Backend Integration In Progress

---

## 📱 Screenshots



---

## ✨ Services

| Service | Description |
|---|---|
| 🍔 Food | Browse restaurants, place orders |
| 🛂 Visa | Document checklist, appointment booking |
| 💇 Salon | Browse salons, book appointments |
| 💊 Pharmacy | Search medicines, request delivery |
| 🚗 Transport | Ride booking (coming soon) |

---

## 🛠 Tech Stack

- **Framework:** Flutter (Dart)
- **Architecture:** Clean Architecture + BLoC / Riverpod
- **Navigation:** Go Router
- **UI:** Custom design system — reusable components, theming, dark mode

---

## 📂 Project Structure

```
lib/
├── core/           # Theme, constants, shared widgets
├── features/
│   ├── home/       # Super app shell + service grid
│   ├── food/       # Food ordering flow
│   ├── visa/       # Visa service flow
│   ├── salon/      # Salon booking flow
│   └── pharmacy/   # Pharmacy flow
└── main.dart
```

---

## 🚀 Getting Started

```bash
# Clone the repo
git clone https://github.com/AliRajab12/super_app.git
cd super_app

# Install dependencies
flutter pub get

# Run the app
flutter run
```

> Requires Flutter 3.x+. No API keys needed — this is a UI-only demo.

---

## 🗺 Roadmap

- [x] Home shell + service navigation
- [x] All service UI screens
- [ ] REST API integration
- [ ] Authentication (OTP flow)
- [ ] State management (BLoC)
- [ ] App Store / Play Store release

---

## 👤 Author

**Ali** — Full-Stack Engineer & Technical PM  
[LinkedIn](https://linkedin.com/in/ali-rajab-ne) · [Portfolio](https://alirajab12.github.io)

---

## 📄 License

MIT © Ali
