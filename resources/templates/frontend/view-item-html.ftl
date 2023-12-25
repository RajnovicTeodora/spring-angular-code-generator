<div>

    <#list properties as property>
    <#if property.class.name == "myplugin.generator.fmmodel.FMPrimitiveProperty">
        <div class="form-group">
            <label for="${property.name}">${property.name}:</label>
        <div><label type="text" id="${property.name}">&nbsp;&nbsp;{{${property.name}}}</label></div>
        </div>
<br/>
    <#else>
        <#if property.class.name == "myplugin.generator.fmmodel.FMReferenceProperty">
        	 <#if property.upper == -1>
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
                    <tr *ngFor="let one${property.name} of ${property.name};" data-cy="entityTable">
                    <td *ngFor="let property of getObjectProperties(one${property.name})">{{ one${property.name}[property] }}</td>
                        <!-- <a [routerLink]="['/grade', grade.id, 'view']">{{ grade.id }}</a> -->
                    </tr>
                    </tbody>
                </table>
            </div>
            </#if>
            <#else>
            proba
        </#if>
    </#if>
    </#list>
    
</div>
  