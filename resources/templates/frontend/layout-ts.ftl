import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NgbNavModule } from '@ng-bootstrap/ng-bootstrap';
<#list classes as class>
import { ${class.name?cap_first}sComponent } from '../${class.name?cap_first}/${class.name?cap_first}s/${class.name?cap_first}s.component';
</#list>  
import { RouterLink, RouterOutlet } from '@angular/router';

@Component({
  selector: 'app-layout',
  standalone: true,
  imports: [
    CommonModule,
    RouterOutlet,
    RouterLink,
    NgbNavModule,
<#list classes as class>
    ${class.name?cap_first}sComponent,
</#list>    
  ],
  templateUrl: './layout.component.html',
})
export class LayoutComponent {}
