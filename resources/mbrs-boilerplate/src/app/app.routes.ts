import { Routes } from '@angular/router';

export const routes: Routes = [
  {
    path: 'grades',
    loadChildren: () =>
      import('./grade/grade.routes').then((m) => m.GRADE_ROUTES),
  },
  {
    path: 'students',
    loadChildren: () =>
      import('./student/student.routes').then((m) => m.STUDENT_ROUTES),
  },
  { path: '', redirectTo: '/students', pathMatch: 'full' }, // Default route
  { path: '**', redirectTo: '/students' },
];
