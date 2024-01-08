<form [formGroup]="${class.getName()?uncap_first}Form" (ngSubmit)="onSubmit()">
  <#list properties as property>
    <#if property.class.name == "myplugin.generator.fmmodel.FMPrimitiveProperty">
      <div class="form-group">
        <label for="${property.name}">${property.name?cap_first}:</label>
        <input type="text" id="${property.name}" formControlName="${property.name}" class="form-control" />
        <div *ngIf="${class.getName()?uncap_first}Form.get('${property.name}')?.invalid && ${class.getName()?uncap_first}Form.get('${property.name}')?.touched" class="text-danger">
          ${property.name?cap_first} is required.
        </div>
      </div>
      <br/>
    <#else>
      <#if property.class.name == "myplugin.generator.fmmodel.FMReferenceProperty">
        <#if property.upper == -1 && (property.cardinality)?? && (property.cardinality == "ManyToMany")>
          <div *ngIf="all${property.name?cap_first}!=null" class="form-group">
            <label>${property.name}:</label>
            <table class="table table-striped">
              <thead>
                <tr>
                  <td *ngFor="let property of getObjectProperties${property.name?cap_first}(all${property.name?cap_first}[0]!)">{{ property }}</td>
                  <td>Add/Delete</td>
                  <th scope="col"></th>
                </tr>
              </thead>
              <tbody>
                <tr *ngFor="let one${property.type} of all${property.name?cap_first};" data-cy="entityTable">
                  <td *ngFor="let property of getObjectProperties${property.name?cap_first}(one${property.type})">{{ getValue${property.name?cap_first}(one${property.type?cap_first}, property!)}}</td>
                  <td *ngIf="check${property.type?cap_first}(this.getValue${property.name?cap_first}(one${property.type?cap_first},'id'!))">
                    <button (click)="this.remove${property.type?cap_first}(this.getValue${property.name?cap_first}(one${property.type?cap_first},'id'!))">Remove</button>
                  </td>
                  <td *ngIf="!check${property.type?cap_first}(this.getValue${property.name?cap_first}(one${property.type?cap_first},'id'!))">
                    <button (click)="this.add${property.type?cap_first}(this.getValue${property.name?cap_first}(one${property.type?cap_first},'id'!))">Add</button>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
         <#elseif property.upper == 1>
          <label>${property.name?cap_first}</label>
          <select [ngModel]="${property.name}?.id" style="margin: 10px; min-width: 10%;" [formControl]="${property.name?uncap_first}Control">
            @for (s of this.all${property.name?cap_first}s; track s) {
              <option [value]="s.id">{{s.id}}</option>
            }
          </select>
        </#if>
      </#if>
    </#if>
  </#list>
  <div>
    <button type="submit" class="btn btn-primary" [disabled]="${class.getName()?uncap_first}Form.invalid">Submit</button>
  </div>
</form>
