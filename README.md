# 💕 BOND101

> A couple log app — use to learn how to love.

BOND101 is a native iOS app that helps couples track, reflect on, and strengthen their relationship. Log shared moments, understand each other better, and build deeper connection over time.

---

## ✨ Features

- **Couple Logging** — Record shared experiences and meaningful moments with your partner.
- **Relationship Insights** — Reflect on your connection and track how it evolves.
- **Private & Secure** — Your data stays between the two of you.
- **Figma-Designed UI** — Carefully crafted interface based on Figma prototypes.

---

## 📁 Project Structure

```
BOND101/
├── iOS/                        # Xcode project & Swift source code
│   └── BOND101.xcodeproj      # Xcode project file
├── src/
│   └── assets/
│       └── figma/              # Figma design exports & assets
├── .gitignore
├── package-lock.json           # Node.js dependency lock file
└── README.md
```

---

## 🛠 Prerequisites

Before you begin, make sure you have the following installed:

| Tool        | Version       | Link                                          |
|-------------|---------------|-----------------------------------------------|
| **Xcode**   | 15.0+         | [Mac App Store](https://apps.apple.com/app/xcode/id497799835) |
| **macOS**   | Ventura 13.5+ | —                                              |
| **Node.js** | 18+           | [nodejs.org](https://nodejs.org/)              |
| **Git**     | latest        | [git-scm.com](https://git-scm.com/)           |

---

## 🚀 Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/HelenaGuo810/BOND101.git
cd BOND101
```

### 2. Install Node dependencies

```bash
npm install
```

### 3. Configure environment variables

Create a `.env` file in the project root (this file is git-ignored for security):

```bash
cp .env.example .env    # if a template exists, or create manually
```

Add any required API keys or configuration values.

### 4. Set up the iOS project

Create your local `Info.plist` (this file is git-ignored to protect secrets):

```bash
# Copy the template if available, or create iOS/Info.plist manually
# with your app's bundle identifier and configuration
```

### 5. Open in Xcode

```bash
open iOS/BOND101.xcodeproj
```

### 6. Build & Run

1. Select a simulator or connected device in Xcode.
2. Press **⌘ + R** to build and run.

---

## ⚙️ Configuration

| File               | Purpose                                     | Git-tracked? |
|--------------------|---------------------------------------------|:------------:|
| `iOS/Info.plist`   | App config, bundle ID, permissions          | ❌            |
| `.env`             | Environment variables / API keys            | ❌            |
| `package-lock.json`| Locked Node.js dependency versions          | ✅            |

> **Note:** Sensitive files like `Info.plist` and `.env` are excluded from version control. You will need to create them locally — ask a team member for the required values if you're onboarding.

---

## 🎨 Design

UI designs and assets live in `src/assets/figma/`. These are exported from Figma and used as reference for building the app's interface.

---

## 🤝 Contributing

Contributions are welcome! Here's how to get started:

1. **Fork** this repository
2. **Create a branch** for your feature or fix:
   ```bash
   git checkout -b feature/my-new-feature
   ```
3. **Commit** your changes with clear messages:
   ```bash
   git commit -m "Add: description of what you changed"
   ```
4. **Push** to your fork and open a **Pull Request**

Please keep PRs focused and well-described.

---

## 📜 License

This project is currently unlicensed. Please contact the repository owner before using or distributing any part of this codebase.

---

## 📬 Contact

Questions or ideas? Open an [issue](https://github.com/HelenaGuo810/BOND101/issues) or reach out to [@HelenaGuo810](https://github.com/HelenaGuo810).

---

<p align="center">
  Made with ❤️ for couples who want to learn how to love better.
</p>
