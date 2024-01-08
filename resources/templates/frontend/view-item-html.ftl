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
                <label>${property.name?cap_first}:</label>
                <table class="table table-striped" *ngIf="${property.name?uncap_first} !== null && ${property.name?uncap_first}?.length > 0">
                    <thead>
                    <tr>
                    <td *ngFor="let property of getHeader(${property.name?uncap_first}[0])">{{ property }}</td>
                    </tr>
                    </thead>
                    <tbody>
                    <tr *ngFor="let one${property.name} of ${property.name?uncap_first};" data-cy="entityTable">
                    <td *ngFor="let value of getObjectProperties(one${property.name})">{{ value }}</td>
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
  