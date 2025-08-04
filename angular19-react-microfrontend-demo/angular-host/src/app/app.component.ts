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
