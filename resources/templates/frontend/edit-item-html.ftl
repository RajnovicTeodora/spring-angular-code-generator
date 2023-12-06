<form [formGroup]="${class.getName()?uncap_first}Form" (ngSubmit)="onSubmit()">
  <#list properties as property>
    <#if property.class.name == "myplugin.generator.fmmodel.FMPrimitiveProperty">
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
   <#if property.class.name == "myplugin.generator.fmmodel.FMReferenceProperty">

            <div class="form-group">
                <label>${property.name}:</label>
                <table class="table table-striped">
                    <thead>
                    <tr>
                    <td *ngFor="let property of getObjectProperties(${property.name})">{{ property }}</td>
                    <th scope="col"></th>

                    </tr>
                    </thead>
                    <tbody>
                    <tr *ngFor="let ${property.name} of ${property.name}s;" data-cy="entityTable">
                     <td *ngFor="let property of getObjectProperties(${property.name})">{{ ${property.name}[property] }}</td>
                        <!-- <a [routerLink]="['/grade', grade.id, 'view']">{{ grade.id }}</a> -->
                    </tr>
                    </tbody>
                </table>
            </div>
        </#if>
  </#if>
      </#list>
</form>
