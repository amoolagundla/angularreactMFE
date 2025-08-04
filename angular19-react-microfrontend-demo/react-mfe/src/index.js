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
