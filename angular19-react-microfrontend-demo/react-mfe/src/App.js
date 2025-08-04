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
