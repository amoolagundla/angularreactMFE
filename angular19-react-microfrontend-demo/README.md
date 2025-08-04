# Angular 19 + React Micro Frontend Demo

This project demonstrates how to integrate React micro frontends into an Angular 19 application using Single-SPA.

## 🚀 Quick Start

### Prerequisites
- Node.js 18+ and npm
- Angular CLI 19+ (`npm install -g @angular/cli@19`)

### Setup & Run

1. **Install dependencies**
   ```bash
   # Install Angular dependencies
   cd angular-host
   npm install
   cd ..
   
   # Install React dependencies
   cd react-mfe
   npm install
   cd ..
   ```

2. **Start the applications**
   
   **Terminal 1 - React Micro Frontend:**
   ```bash
   cd react-mfe
   npm start
   ```
   (Runs on http://localhost:4201)
   
   **Terminal 2 - Angular Host:**
   ```bash
   cd angular-host
   ng serve
   ```
   (Runs on http://localhost:4200)

3. **Open the app**
   Visit http://localhost:4200 and navigate between Angular and React modules!

## 🆕 Angular 19 Features

- ✅ **Standalone Components** (default)
- ✅ **Signals API** for reactive state
- ✅ **New Control Flow** (@if, @for syntax)
- ✅ **Enhanced TypeScript** support
- ✅ **Improved Performance** and bundle sizes

## 🎯 Architecture

### Single-SPA Configuration
- **Angular Host** (Port 4200): Main shell application
- **React Micro Frontend** (Port 4201): Independent React app
- **Route-based activation**: `/react` route loads React app

## 📁 Project Structure

```
angular19-react-microfrontend-demo/
├── angular-host/              # Angular 19 host application
│   ├── src/
│   │   ├── app/
│   │   │   ├── home/          # Angular home component
│   │   │   ├── about/         # Angular about component
│   │   │   ├── app.component.ts # Main app component
│   │   │   └── app.routes.ts   # Routing configuration
│   │   ├── main.ts            # Single-SPA setup
│   │   └── index.html         # SystemJS imports
│   └── package.json
├── react-mfe/                # React micro frontend
│   ├── src/
│   │   ├── App.js             # Main React component
│   │   ├── App.css            # React styles
│   │   └── index.js           # Single-SPA React setup
│   ├── webpack.config.js      # Webpack configuration
│   └── package.json
└── README.md
```

## 🛠️ Development

### Adding New Features
- **Angular side**: Add new standalone components and routes
- **React side**: Add new components and update App.js

### Building for Production
```bash
# Build Angular
cd angular-host
ng build

# Build React
cd react-mfe
npm run build
```

## 📚 Learn More

- [Angular 19 Documentation](https://angular.io/)
- [Single-SPA Documentation](https://single-spa.js.org/)
- [React 18 Documentation](https://reactjs.org/)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request
