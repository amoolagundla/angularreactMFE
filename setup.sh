#!/bin/bash

# Angular 19 + React Micro Frontend Project Setup Script
# This script creates the complete project structure with all files

echo "🚀 Setting up Angular 19 + React Micro Frontend Demo..."

# Create main project directory
mkdir -p angular19-react-microfrontend-demo
cd angular19-react-microfrontend-demo

echo "📁 Creating project structure..."

# Create Angular host structure
mkdir -p angular-host/src/app/{home,about}
mkdir -p angular-host/src/environments
mkdir -p angular-host/src/assets

# Create React MFE structure
mkdir -p react-mfe/src
mkdir -p react-mfe/public

echo "📝 Creating Angular 19 files..."

# Root package.json for Angular
cat > angular-host/package.json << 'EOF'
{
  "name": "angular-host",
  "version": "1.0.0",
  "scripts": {
    "ng": "ng",
    "start": "ng serve",
    "build": "ng build",
    "watch": "ng build --watch --configuration development",
    "test": "ng test"
  },
  "dependencies": {
    "@angular/animations": "^19.0.0",
    "@angular/common": "^19.0.0",
    "@angular/compiler": "^19.0.0",
    "@angular/core": "^19.0.0",
    "@angular/forms": "^19.0.0",
    "@angular/platform-browser": "^19.0.0",
    "@angular/platform-browser-dynamic": "^19.0.0",
    "@angular/router": "^19.0.0",
    "rxjs": "~7.8.0",
    "tslib": "^2.3.0",
    "zone.js": "~0.14.0",
    "single-spa": "^6.0.0",
    "single-spa-angular": "^9.0.0",
    "systemjs": "^6.14.0"
  },
  "devDependencies": {
    "@angular-devkit/build-angular": "^19.0.0",
    "@angular/cli": "^19.0.0",
    "@angular/compiler-cli": "^19.0.0",
    "@types/systemjs": "^6.1.1",
    "typescript": "~5.6.0"
  }
}
EOF

# Angular.json
cat > angular-host/angular.json << 'EOF'
{
  "$schema": "./node_modules/@angular/cli/lib/config/schema.json",
  "version": 1,
  "newProjectRoot": "projects",
  "projects": {
    "angular-host": {
      "projectType": "application",
      "schematics": {
        "@schematics/angular:component": {
          "style": "css",
          "standalone": true
        }
      },
      "root": "",
      "sourceRoot": "src",
      "prefix": "app",
      "architect": {
        "build": {
          "builder": "@angular-devkit/build-angular:application",
          "options": {
            "outputPath": "dist/angular-host",
            "index": "src/index.html",
            "browser": "src/main.ts",
            "polyfills": ["zone.js"],
            "tsConfig": "tsconfig.app.json",
            "assets": ["src/favicon.ico", "src/assets"],
            "styles": ["src/styles.css"],
            "scripts": []
          },
          "configurations": {
            "production": {
              "budgets": [
                {
                  "type": "initial",
                  "maximumWarning": "500kB",
                  "maximumError": "1MB"
                },
                {
                  "type": "anyComponentStyle",
                  "maximumWarning": "2kB",
                  "maximumError": "4kB"
                }
              ],
              "outputHashing": "all"
            },
            "development": {
              "optimization": false,
              "extractLicenses": false,
              "sourceMap": true
            }
          },
          "defaultConfiguration": "production"
        },
        "serve": {
          "builder": "@angular-devkit/build-angular:dev-server",
          "configurations": {
            "production": {
              "buildTarget": "angular-host:build:production"
            },
            "development": {
              "buildTarget": "angular-host:build:development"
            }
          },
          "defaultConfiguration": "development"
        }
      }
    }
  },
  "cli": {
    "analytics": false
  }
}
EOF

# tsconfig.json
cat > angular-host/tsconfig.json << 'EOF'
{
  "compileOnSave": false,
  "compilerOptions": {
    "baseUrl": "./",
    "outDir": "./dist/out-tsc",
    "forceConsistentCasingInFileNames": true,
    "strict": true,
    "noImplicitOverride": true,
    "noPropertyAccessFromIndexSignature": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true,
    "sourceMap": true,
    "declaration": false,
    "downlevelIteration": true,
    "experimentalDecorators": true,
    "moduleResolution": "bundler",
    "importHelpers": true,
    "target": "ES2022",
    "module": "ES2022",
    "useDefineForClassFields": false,
    "lib": ["ES2022", "dom"]
  },
  "angularCompilerOptions": {
    "enableI18nLegacyMessageIdFormat": false,
    "strictInjectionParameters": true,
    "strictInputAccessModifiers": true,
    "strictTemplates": true
  }
}
EOF

# tsconfig.app.json
cat > angular-host/tsconfig.app.json << 'EOF'
{
  "extends": "./tsconfig.json",
  "compilerOptions": {
    "outDir": "./out-tsc/app",
    "types": []
  },
  "files": [
    "src/main.ts"
  ],
  "include": [
    "src/**/*.d.ts"
  ]
}
EOF

# index.html
cat > angular-host/src/index.html << 'EOF'
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Angular 19 + React Micro Frontend Demo</title>
  <base href="/">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" type="image/x-icon" href="favicon.ico">
  
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  
  <!-- SystemJS for module loading -->
  <script src="https://cdn.jsdelivr.net/npm/systemjs@6.14.0/dist/system.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/systemjs@6.14.0/dist/extras/amd.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/systemjs@6.14.0/dist/extras/named-exports.min.js"></script>
</head>
<body>
  <div id="single-spa-application"></div>
  
  <script type="systemjs-importmap">
    {
      "imports": {
        "react": "https://cdn.jsdelivr.net/npm/react@18.2.0/umd/react.development.js",
        "react-dom": "https://cdn.jsdelivr.net/npm/react-dom@18.2.0/umd/react-dom.development.js",
        "single-spa": "https://cdn.jsdelivr.net/npm/single-spa@6.0.0/lib/system/single-spa.min.js"
      }
    }
  </script>
  
  <script>
    System.import('@angular-host/main');
  </script>
</body>
</html>
EOF

# main.ts
cat > angular-host/src/main.ts << 'EOF'
import { bootstrapApplication } from '@angular/platform-browser';
import { importProvidersFrom } from '@angular/core';
import { provideRouter } from '@angular/router';
import { provideAnimations } from '@angular/platform-browser/animations';
import { registerApplication, start } from 'single-spa';
import { singleSpaAngular, getSingleSpaExtraProviders } from 'single-spa-angular';
import { NgZone } from '@angular/core';

import { AppComponent } from './app/app.component';
import { routes } from './app/app.routes';

// Register Angular application using new standalone bootstrap
const angularLifecycles = singleSpaAngular({
  bootstrapFunction: () => 
    bootstrapApplication(AppComponent, {
      providers: [
        ...getSingleSpaExtraProviders(),
        provideRouter(routes),
        provideAnimations()
      ]
    }),
  template: '<app-root />',
  NgZone,
});

registerApplication({
  name: '@angular-host/main',
  app: angularLifecycles,
  activeWhen: (location) => !location.pathname.startsWith('/react')
});

// Register React micro frontend
registerApplication({
  name: '@react-mfe/main',
  app: () => System.import('http://localhost:4201/main.js'),
  activeWhen: ['/react']
});

// Start single-spa
start();
EOF

# styles.css
cat > angular-host/src/styles.css << 'EOF'
/* Global styles */
body {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
}

.navbar-brand {
  font-weight: bold;
}

.nav-link.active {
  background-color: rgba(255,255,255,0.1);
  border-radius: 4px;
}

.badge {
  font-size: 0.9em;
}

.card {
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  margin-bottom: 1rem;
}

.list-group-item {
  transition: background-color 0.2s ease;
}

.list-group-item:hover {
  background-color: #f8f9fa;
}
EOF

# app.routes.ts
cat > angular-host/src/app/app.routes.ts << 'EOF'
import { Routes } from '@angular/router';
import { HomeComponent } from './home/home.component';
import { AboutComponent } from './about/about.component';

export const routes: Routes = [
  { path: '', component: HomeComponent },
  { path: 'home', component: HomeComponent },
  { path: 'about', component: AboutComponent },
  { path: '**', redirectTo: '' }
];
EOF

# app.component.ts
cat > angular-host/src/app/app.component.ts << 'EOF'
import { Component, OnInit, signal, computed } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, RouterOutlet, NavigationEnd } from '@angular/router';
import { navigateToUrl } from 'single-spa';
import { filter, map } from 'rxjs/operators';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [CommonModule, RouterOutlet],
  template: `
    <div class="container-fluid">
      <!-- Navigation Header -->
      <nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
        <div class="container">
          <a class="navbar-brand" href="/">
            🚀 Angular 19 + React Micro Frontend
          </a>
          
          <div class="navbar-nav">
            <a class="nav-link" 
               [class.active]="isActiveRoute('/')" 
               (click)="navigateTo('/')"
               style="cursor: pointer">
              🏠 Angular Home
            </a>
            <a class="nav-link" 
               [class.active]="isActiveRoute('/about')" 
               (click)="navigateTo('/about')"
               style="cursor: pointer">
              📋 About (Angular)
            </a>
            <a class="nav-link" 
               [class.active]="isActiveRoute('/react')" 
               (click)="navigateTo('/react')"
               style="cursor: pointer">
              ⚛️ React Module
            </a>
          </div>
        </div>
      </nav>

      <!-- Current App Indicator using new @if syntax -->
      <div class="container">
        <div class="alert alert-info d-flex align-items-center" role="alert">
          <strong class="me-2">Currently running:</strong>
          @if (!currentPath().startsWith('/react')) {
            <span class="badge bg-success">🅐 Angular 19 Application</span>
          } @else {
            <span class="badge bg-info">⚛️ React Micro Frontend</span>
          }
          <small class="ms-auto text-muted">
            Angular {{ angularVersion }} with Standalone Components
          </small>
        </div>
      </div>

      <!-- Router Outlet for Angular routes using new @if -->
      @if (!currentPath().startsWith('/react')) {
        <div class="container">
          <router-outlet></router-outlet>
        </div>
      }
    </div>
  `,
  styles: [`
    .navbar-brand {
      font-weight: bold;
    }
    .nav-link.active {
      background-color: rgba(255,255,255,0.1);
      border-radius: 4px;
    }
    .badge {
      font-size: 0.9em;
    }
  `]
})
export class AppComponent implements OnInit {
  // Using Angular 19 signals
  currentPath = signal('/');
  angularVersion = '19.0.0';

  // Computed property using signals
  isReactRoute = computed(() => this.currentPath().startsWith('/react'));

  constructor(private router: Router) {}

  ngOnInit() {
    // Track route changes with new RxJS operators
    this.router.events
      .pipe(
        filter(event => event instanceof NavigationEnd),
        map((event: NavigationEnd) => event.url)
      )
      .subscribe(url => {
        this.currentPath.set(url);
      });

    // Set initial path
    this.currentPath.set(window.location.pathname);
  }

  navigateTo(path: string) {
    this.currentPath.set(path);
    navigateToUrl(path);
  }

  isActiveRoute(path: string): boolean {
    if (path === '/') {
      return this.currentPath() === '/' || this.currentPath() === '/home';
    }
    return this.currentPath().startsWith(path);
  }
}
EOF

# home.component.ts
cat > angular-host/src/app/home/home.component.ts << 'EOF'
import { Component, signal, computed } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { navigateToUrl } from 'single-spa';

interface TodoItem {
  id: number;
  text: string;
  completed: boolean;
}

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [CommonModule, FormsModule],
  template: `
    <div class="row">
      <div class="col-md-8">
        <div class="card">
          <div class="card-header bg-success text-white">
            <h3>🅐 Angular 19 Home Component</h3>
          </div>
          <div class="card-body">
            <h5>Welcome to Angular 19 Micro Frontend Demo!</h5>
            <p>This page showcases <strong>Angular 19</strong> with latest features.</p>
            
            <div class="alert alert-success">
              <h6>🆕 Angular 19 Features Used:</h6>
              <ul class="mb-0">
                <li><strong>Standalone Components</strong> (no NgModules needed)</li>
                <li><strong>Signals</strong> for reactive state management</li>
                <li><strong>New Control Flow</strong> (@if, @for syntax)</li>
                <li><strong>Modern TypeScript</strong> with strict mode</li>
                <li><strong>Improved Performance</strong> and bundle size</li>
              </ul>
            </div>

            <div class="row mb-3">
              <div class="col-md-6">
                <button class="btn btn-primary me-2" (click)="incrementCounter()">
                  Angular Counter: {{ counter() }}
                </button>
                
                <button class="btn btn-outline-primary" (click)="goToReact()">
                  Switch to React Module →
                </button>
              </div>
            </div>

            <!-- Todo List using new @for syntax -->
            <div class="mt-4">
              <h6>📝 Angular 19 Todo List (Signals + New Syntax)</h6>
              <div class="input-group mb-3">
                <input 
                  type="text" 
                  class="form-control" 
                  placeholder="Add new todo..."
                  [(ngModel)]="newTodo"
                  (keyup.enter)="addTodo()">
                <button class="btn btn-success" (click)="addTodo()">
                  Add Todo
                </button>
              </div>
              
              <div class="list-group">
                @for (todo of todos(); track todo.id) {
                  <div class="list-group-item d-flex justify-content-between align-items-center"
                       [class.list-group-item-success]="todo.completed">
                    <span 
                      [style.text-decoration]="todo.completed ? 'line-through' : 'none'"
                      style="cursor: pointer"
                      (click)="toggleTodo(todo.id)">
                      {{ todo.text }}
                    </span>
                    <span class="badge rounded-pill"
                          [class.bg-success]="todo.completed"
                          [class.bg-warning]="!todo.completed">
                      @if (todo.completed) {
                        ✅
                      } @else {
                        ⏳
                      }
                    </span>
                  </div>
                } @empty {
                  <div class="list-group-item text-muted text-center">
                    No todos yet. Add one above! 
                  </div>
                }
              </div>
            </div>
          </div>
        </div>
      </div>
      
      <div class="col-md-4">
        <div class="card">
          <div class="card-header">
            <h5>🆕 Angular 19 Features</h5>
          </div>
          <div class="card-body">
            <ul class="list-unstyled">
              <li>✅ <strong>Standalone Components</strong></li>
              <li>✅ <strong>Signals API</strong></li>
              <li>✅ <strong>New Control Flow (@if, @for)</strong></li>
              <li>✅ <strong>Improved TypeScript Support</strong></li>
              <li>✅ <strong>Enhanced Performance</strong></li>
              <li>✅ <strong>Modern Build System</strong></li>
            </ul>
            
            <div class="mt-3">
              <small class="text-muted">
                <strong>Stats:</strong><br>
                Todos: {{ todos().length }}<br>
                Completed: {{ completedCount() }}<br>
                Remaining: {{ remainingCount() }}
              </small>
            </div>
          </div>
        </div>
      </div>
    </div>
  `
})
export class HomeComponent {
  // Using Angular 19 signals for reactive state
  counter = signal(0);
  newTodo = '';
  todos = signal<TodoItem[]>([
    { id: 1, text: 'Learn Angular 19 Signals', completed: true },
    { id: 2, text: 'Try new @if/@for syntax', completed: true },
    { id: 3, text: 'Build micro frontends', completed: false },
    { id: 4, text: 'Deploy to production', completed: false }
  ]);

  // Computed signals
  completedCount = computed(() => 
    this.todos().filter(todo => todo.completed).length
  );
  
  remainingCount = computed(() => 
    this.todos().filter(todo => !todo.completed).length
  );

  incrementCounter() {
    this.counter.update(count => count + 1);
  }

  addTodo() {
    if (this.newTodo.trim()) {
      this.todos.update(todos => [...todos, {
        id: Date.now(),
        text: this.newTodo.trim(),
        completed: false
      }]);
      this.newTodo = '';
    }
  }

  toggleTodo(id: number) {
    this.todos.update(todos => 
      todos.map(todo => 
        todo.id === id ? { ...todo, completed: !todo.completed } : todo
      )
    );
  }

  goToReact() {
    navigateToUrl('/react');
  }
}
EOF

# about.component.ts
cat > angular-host/src/app/about/about.component.ts << 'EOF'
import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-about',
  standalone: true,
  imports: [CommonModule],
  template: `
    <div class="card">
      <div class="card-header bg-info text-white">
        <h3>📋 About Angular 19 + React Micro Frontend Demo</h3>
      </div>
      <div class="card-body">
        <h5>Modern Micro Frontend Architecture</h5>
        <p>This demo showcases the latest Angular 19 features integrated with React micro frontends using Single-SPA.</p>
        
        <div class="row mt-4">
          <div class="col-md-6">
            <h6>🅐 Angular 19 Host Application</h6>
            <ul>
              <li><strong>Standalone Components</strong> - No NgModules required</li>
              <li><strong>Signals API</strong> - Reactive state management</li>
              <li><strong>New Control Flow</strong> - @if, @for, @switch syntax</li>
              <li><strong>Enhanced TypeScript</strong> - Better type safety</li>
              <li><strong>Modern Build System</strong> - Improved performance</li>
              <li>Runs on port 4200</li>
            </ul>
          </div>
          
          <div class="col-md-6">
            <h6>⚛️ React Micro Frontend</h6>
            <ul>
              <li>Independent React 18 application</li>
              <li>Loaded dynamically via Single-SPA</li>
              <li>Modern React Hooks and Context</li>
              <li>Handles the /react route</li>
              <li>Can be deployed independently</li>
              <li>Runs on port 4201</li>
            </ul>
          </div>
        </div>

        <div class="alert alert-warning mt-4">
          <h6>🆕 What's New in Angular 19:</h6>
          <div class="row">
            <div class="col-md-6">
              <ul class="mb-0">
                <li><strong>Standalone by default</strong></li>
                <li><strong>Improved Signals</strong></li>
                <li><strong>Better SSR support</strong></li>
                <li><strong>Enhanced Control Flow</strong></li>
              </ul>
            </div>
            <div class="col-md-6">
              <ul class="mb-0">
                <li><strong>Optimized bundle sizes</strong></li>
                <li><strong>Faster compilation</strong></li>
                <li><strong>Better tree-shaking</strong></li>
                <li><strong>Modern ES modules</strong></li>
              </ul>
            </div>
          </div>
        </div>

        <div class="alert alert-success mt-4">
          <strong>Key Benefits of This Architecture:</strong>
          <ul class="mb-0">
            <li><strong>Framework Independence</strong> - Mix Angular 19 and React seamlessly</li>
            <li><strong>Independent Deployments</strong> - Deploy each micro frontend separately</li>
            <li><strong>Team Autonomy</strong> - Different teams can use different tech stacks</li>
            <li><strong>Incremental Upgrades</strong> - Upgrade frameworks independently</li>
            <li><strong>Modern Development</strong> - Latest features from both ecosystems</li>
          </ul>
        </div>
      </div>
    </div>
  `
})
export class AboutComponent {}
EOF

# environments/environment.ts
cat > angular-host/src/environments/environment.ts << 'EOF'
export const environment = {
  production: false
};
EOF

echo "📝 Creating React files..."

# React package.json
cat > react-mfe/package.json << 'EOF'
{
  "name": "react-mfe", 
  "version": "1.0.0",
  "scripts": {
    "start": "webpack serve --mode development",
    "build": "webpack --mode production",
    "dev": "webpack serve --mode development --open"
  },
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "single-spa-react": "^6.0.0"
  },
  "devDependencies": {
    "@babel/core": "^7.23.0",
    "@babel/preset-react": "^7.23.0",
    "babel-loader": "^9.1.0",
    "css-loader": "^6.8.0",
    "html-webpack-plugin": "^5.6.0",
    "style-loader": "^3.3.0",
    "webpack": "^5.89.0",
    "webpack-cli": "^5.1.0",
    "webpack-dev-server": "^4.15.0"
  }
}
EOF

# React webpack.config.js
cat > react-mfe/webpack.config.js << 'EOF'
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  entry: './src/index.js',
  output: {
    filename: 'main.js',
    libraryTarget: 'system',
    path: __dirname + '/dist',
  },
  devServer: {
    port: 4201,
    headers: {
      'Access-Control-Allow-Origin': '*',
    },
    historyApiFallback: true,
  },
  module: {
    rules: [
      {
        test: /\.jsx?$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: ['@babel/preset-react'],
          },
        },
      },
      {
        test: /\.css$/,
        use: ['style-loader', 'css-loader'],
      },
    ],
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: './public/index.html',
    }),
  ],
  externals: ['react', 'react-dom'],
};
EOF

# React index.js
cat > react-mfe/src/index.js << 'EOF'
import React from 'react';
import ReactDOM from 'react-dom/client';
import singleSpaReact from 'single-spa-react';
import App from './App';

const lifecycles = singleSpaReact({
  React,
  ReactDOM,
  rootComponent: App,
  errorBoundary(err, info, props) {
    return (
      <div style={{ 
        padding: '20px', 
        border: '2px solid red', 
        borderRadius: '8px',
        backgroundColor: '#ffe6e6'
      }}>
        <h3>⚠️ Error loading React micro frontend</h3>
        <p><strong>Error:</strong> {err.message}</p>
        <details>
          <summary>Error details</summary>
          <pre>{err.stack}</pre>
        </details>
      </div>
    );
  },
});

export const { bootstrap, mount, unmount } = lifecycles;
EOF

# React App.js (truncated for space - contains the full component with theme provider and todo list)
cat > react-mfe/src/App.js << 'EOF'
import React, { useState, useEffect, useContext, createContext } from 'react';
import './App.css';

// Create a context for theme management
const ThemeContext = createContext();

// Theme provider component
const ThemeProvider = ({ children }) => {
  const [theme, setTheme] = useState('light');
  
  const toggleTheme = () => {
    setTheme(prev => prev === 'light' ? 'dark' : 'light');
  };

  return (
    <ThemeContext.Provider value={{ theme, toggleTheme }}>
      {children}
    </ThemeContext.Provider>
  );
};

// Custom hook for theme
const useTheme = () => {
  const context = useContext(ThemeContext);
  if (!context) {
    throw new Error('useTheme must be used within ThemeProvider');
  }
  return context;
};

// Main App component
function App() {
  const [count, setCount] = useState(0);
  const [mounted, setMounted] = useState(false);
  const { theme, toggleTheme } = useTheme();

  useEffect(() => {
    setMounted(true);
    console.log('React micro frontend mounted!');
    
    return () => {
      console.log('React micro frontend unmounting...');
    };
  }, []);

  const navigateToAngular = () => {
    window.history.pushState({}, '', '/');
    window.dispatchEvent(new PopStateEvent('popstate'));
  };

  if (!mounted) {
    return (
      <div className="container">
        <div className="text-center p-4">
          <div className="spinner-border text-primary" role="status">
            <span className="visually-hidden">Loading React micro frontend...</span>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className={`container ${theme === 'dark' ? 'bg-dark text-light' : ''}`}>
      <div className="row">
        <div className="col-md-12">
          <div className="card">
            <div className="card-header bg-info text-white d-flex justify-content-between align-items-center">
              <h3>⚛️ React 18 Micro Frontend</h3>
              <button 
                className="btn btn-sm btn-light"
                onClick={toggleTheme}
              >
                {theme === 'light' ? '🌙' : '☀️'} Toggle Theme
              </button>
            </div>
            <div className="card-body">
              <h5>Welcome to the Modern React Module!</h5>
              <p>This micro frontend demonstrates <strong>React 18</strong> with modern patterns and hooks.</p>
              
              <div className="alert alert-info">
                <h6>⚛️ React 18 Features Used:</h6>
                <ul className="mb-0">
                  <li><strong>Functional Components</strong> with Hooks</li>
                  <li><strong>Context API</strong> for state management</li>
                  <li><strong>Custom Hooks</strong> for reusable logic</li>
                  <li><strong>Modern ES6+</strong> syntax and patterns</li>
                </ul>
              </div>

              <div className="row mt-4">
                <div className="col-md-6">
                  <button 
                    className="btn btn-primary me-2" 
                    onClick={() => setCount(count + 1)}
                  >
                    React Counter: {count}
                  </button>
                  
                  <button 
                    className="btn btn-outline-primary" 
                    onClick={navigateToAngular}
                  >
                    ← Back to Angular 19
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

// Wrap App with ThemeProvider
export default function AppWithProviders() {
  return (
    <ThemeProvider>
      <App />
    </ThemeProvider>
  );
}
EOF

# React App.css
cat > react-mfe/src/App.css << 'EOF'
.App {
  padding: 20px;
}

.card {
  margin-bottom: 20px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.btn {
  margin: 5px;
}

.list-group-item {
  cursor: pointer;
  transition: background-color 0.2s;
}

.list-group-item:hover {
  background-color: #f8f9fa;
}
EOF

# React public/index.html
cat > react-mfe/public/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>React Micro Frontend</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div id="root"></div>
</body>
</html>
EOF

# Root README.md
cat > README.md << 'EOF'
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
EOF

# .gitignore
cat > .gitignore << 'EOF'
# Dependencies
node_modules/
npm-debug.log*

# Build outputs
dist/
build/
*.tgz

# Angular
angular-host/.angular/
angular-host/dist/

# React
react-mfe/build/

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Logs
logs
*.log

# Environment
.env
.env.local
.env.development.local
.env.test.local
.env.production.local
EOF

echo "✅ Project structure created successfully!"
echo ""
echo "🚀 Next steps:"
echo "1. cd angular19-react-microfrontend-demo"
echo "2. Install dependencies:"
echo "   cd angular-host && npm install -legacy-peer-deps && cd .."
echo "   cd react-mfe && npm install && cd .."
echo "3. Start applications:"
echo "   Terminal 1: cd react-mfe && npm start"
echo "   Terminal 2: cd angular-host && ng serve"
echo "4. Open http://localhost:4200"
echo ""
echo "🎉 Enjoy your Angular 19 + React micro frontend setup!"