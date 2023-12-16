<ul ngbNav #nav="ngbNav" class="nav-tabs">
<#list classes as class>
  <li ngbNavItem>
    <a ngbNavLink [routerLink]="['/${class.name?uncap_first}']" routerLinkActive="active"
      >${class.name}s</a
    >
  </li>
</#list>
</ul>

<router-outlet></router-outlet>
