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
              <li><strong>New Control Flow</strong> - &#64;if, &#64;for, &#64;switch syntax</li>
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
