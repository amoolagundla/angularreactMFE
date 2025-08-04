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
