<#assign identifier = 'id'>
<#list primitiveProperties as prim>
  <#if prim.isId>
    <#assign identifier = prim.name>
  </#if>
</#list>
<button (click)="create()" class="btn btn-primary">
  <fa-icon [icon]="faAdd"></fa-icon>
</button>
<table class="table table-striped">
  <thead>
    <tr>
      <th scope="col">#</th>
      <#list primitiveProperties as property>
      <th scope="col">${property.name?cap_first}</th>
      </#list>
    </tr>
  </thead>
  <tbody>
  @for (${class.name?lower_case} of ${class.name?lower_case}s; track ${class.name?lower_case}.${identifier?lower_case}; let i = $index) {
  <tr>
      <th scope="row">{{ i + 1 }}</th>
      <#list primitiveProperties as property>
      <td>
        {{ ${class.name?lower_case}.${property.name?lower_case} }}
      </td>
      </#list>
      <td>
        <button (click)="open(${class.name?lower_case}.${identifier?lower_case})" class="btn btn-info">
          <fa-icon [icon]="faEdit"></fa-icon>
        </button>
      </td>
      <td>
        <button (click)="delete(${class.name?lower_case})" class="btn btn-danger">
          <fa-icon [icon]="faTrash"></fa-icon>
        </button>
      </td>
      <td>
        <button (click)="view(${class.name?lower_case}.${identifier?lower_case})" class="btn btn-info">
          <fa-icon [icon]="faInfo"></fa-icon>
        </button>
      </td>
  </tr>
  }
  </tbody>
</table>