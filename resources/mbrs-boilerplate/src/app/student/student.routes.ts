import { Routes } from '@angular/router';
import { StudentsComponent } from './students/students.component';
import { StudentEditComponent } from './student-edit/student-edit.component';
import { StudentViewComponent } from './student-view/student-view.component';

export const STUDENT_ROUTES: Routes = [
  { path: '', component: StudentsComponent },
  { path: 'new', component: StudentEditComponent },
  { path: ':id', component: StudentEditComponent },
  { path: 'view/:id', component: StudentViewComponent },
];
// @NgModule({
//   imports: [RouterModule.forChild(STUDENT_ROUTES)],
//   exports: [RouterModule],
// })
// export class StudentRoutingModule {}
