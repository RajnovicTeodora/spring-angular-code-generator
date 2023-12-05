<form [formGroup]="${class.getName()?uncap_first}Form" (ngSubmit)="onSubmit()">
  <#list properties as property>
    <#if property.class.name == "FMPrimitiveProperty">
    <div class="form-group">
        <label for="${property.name}">${property.name}:</label>
        <input type="text" id="name" formControlName="${property.name}" class="form-control" />
        <div
        *ngIf="
            ${class.getName()?uncap_first}Form.get('${property.name}')?.invalid && ${class.getName()?uncap_first}Form.get('${property.name}')?.touched
        "
        class="text-danger"
        >
        ${property.name} is required.
        </div>
    </div>
    
  <button
    type="submit"
    class="btn btn-primary"
    [disabled]="${class.getName()?uncap_first}Form.invalid"
  >
    Submit
  </button>
<br/>
<#else>
   <#if property.class.name == "FMReferenceProperty">

            <div class="form-group">
                <label>${property.name}:</label>
                <table class="table table-striped">
                    <thead>
                    <tr>
                     <#list property.properties as p>
                        <#if p.class.name == "FMPrimitiveProperty">
                            <th scope="col" ><span>${p.name}</span> </th>
                        </#if>
                    </#list>
                    <th scope="col"></th>

                    </tr>
                    </thead>
                    <tbody>
                    <tr *ngFor="let ${property.name} of ${property.name}s;" data-cy="entityTable">
                    <#list property.properties as p>
                        <#if p.class.name == "FMPrimitiveProperty">
                             <td>{{ ${property.name}.${p.name} }}</td>
                        </#if>
                    </#list>
                        <!-- <a [routerLink]="['/grade', grade.id, 'view']">{{ grade.id }}</a> -->
                    </tr>
                    </tbody>
                </table>
            </div>
        </#if>
  </#if>
      </#list>
</form>
