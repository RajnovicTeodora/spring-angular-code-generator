import { Routes } from '@angular/router';

export const routes: Routes = [
<#list classes as class>
    {
    	path: '${class.name?uncap_first}',
    	loadChildren: () =>
    		import('./${class.name}/${class.name}.routes').then((r) => r.${class.name?upper_case}_ROUTES),
    },
</#list>
];
