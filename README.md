# ⚡ DashView

[![PowerShell Gallery](https://img.shields.io/powershellgallery/v/DashView.svg?style=flat-square)](https://www.powershellgallery.com/packages/DashView)
[![Downloads](https://img.shields.io/powershellgallery/dt/DashView.svg?style=flat-square)](https://www.powershellgallery.com/packages/DashView)
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](LICENSE)
[![GitHub Repo](https://img.shields.io/badge/GitHub-a--random--fox/DashView-lightgrey.svg?style=flat-square&logo=github)](https://github.com/a-random-fox/DashView)

A PowerShell dashboard that displays a system summary with animated typing and custom fonts, plus built-in tools for specialized system repair and cumulative Windows + application + module updates.

---

### 🚀 Installation
```powershell
Install-Module DashView -Scope CurrentUser
```

To update:
```powershell
Update-Module DashView
```

To import manually (if cloned or downloaded):
```powershell
Import-Module .\DashView\DashView.psd1 -Force
```

---

### 💡 Features
- 🎨 **Animated Dashboard** – Displays live system info with dynamic typing  
- 🔧 **Repair Utilities** – System and network repair functions for maintenance  
- 📦 **Cumulative Updates** – One command to update Windows, apps, and PowerShell modules  
- 🖋️ **Font Customization** – Includes Terminus TTF font for consistent terminal visuals  
- ⚙️ **Lightweight & Modular** – Built with PowerShell 5.1+ compatibility  

---

### 🧩 Commands Overview
| Function | Description |
|-----------|-------------|
| **Show-DashView** | Launches the interactive dashboard UI |
| **Write-DashType** | Animates text output with a typing effect |
| **Install-DashFont** | Installs and applies the Terminus font |
| **Start-DashRepair** | Performs system and network repair routines |
| **Install-DashUpdate** | Runs cumulative updates across Windows, applications, and modules |

---

### 🧠 Usage Examples
Run the dashboard:
```powershell
Show-DashView
```

Run a quick repair and update sequence:
```powershell
Start-DashRepair
Install-DashUpdate
```

Install the custom font:
```powershell
Install-DashFont
```

---

### 🧰 Requirements
- Windows 10 or later  
- PowerShell 5.1 or PowerShell 7+  
- Administrator privileges for repair/update operations  

---

### 🧑‍💻 Contributing
Pull requests are welcome!  
If you’d like to contribute new features or fix bugs, please open an issue first to discuss your ideas.

---

### 🪪 License
This project is licensed under the [MIT License](LICENSE).  
© 2025 Ryan Schubert (`a-random-fox`)

---

### 🔗 Links
[Project Page](https://github.com/a-random-fox/DashView) ·  
[PowerShell Gallery](https://www.powershellgallery.com/packages/DashView) ·  
[Report Issues](https://github.com/a-random-fox/DashView/issues)
