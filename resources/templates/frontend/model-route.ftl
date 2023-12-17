import { Routes } from '@angular/router';
import { ${class.name}sComponent } from './${class.name}s/${class.name}s.component';
import { ${class.name}EditComponent } from './${class.name}-edit/${class.name?uncap_first}-edit.component';
import { ${class.name}ViewComponent } from './${class.name}-view/${class.name?uncap_first}-view.component';

export const ${class.name?upper_case}_ROUTES: Routes = [
  { path: '', component: ${class.name}sComponent },
  { path: 'new', component: ${class.name}EditComponent },
  { path: ':id', component: ${class.name}EditComponent },
  { path: 'view/:id', component: ${class.name}ViewComponent },
];