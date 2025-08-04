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
