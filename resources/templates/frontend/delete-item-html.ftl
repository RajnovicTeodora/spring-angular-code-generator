<#assign hasIdProperty = "">
<#list properties as property>
 <#--<#if property.type == "String" && property.type == "boolean" && property.type == "byte" && property.type == "int" && property.type == "float" && property.type == "Integer" && property.type == "double" && property.type == "short" && property.type == "long" && property.type == "char">-->
 <#if property.class.name == "myplugin.generator.fmmodel.FMPrimitiveProperty">
  <#if property.generationType?exists && property.generationType != null>
    <#if property.generationType.getName() == "IDENTITY">
      <#assign hasIdProperty = true>
      <#assign idName = property.name>
    </#if>
    </#if>
  </#if>
</#list>



<form *ngIf="${class.name?uncap_first}" name="deleteForm" (ngSubmit)="confirmDelete(${class.getName()?uncap_first}.id!)">
    <div class="modal-header">
      <h4 class="modal-title">Confirmation of deleting</h4>
  
      <button type="button" class="btn-close" data-dismiss="modal" aria-hidden="true" (click)="cancel()">&times;</button>
    </div>
  
    <div class="modal-body">
      <p>
      <#if hasIdProperty != "">
        Are you sure you want to delete this ${class.getName()}?  {{ ${class.getName()?uncap_first}.${idName}}}
      <#else>
      Are you sure you want to delete this ${class.getName()}?  {{ ${class.getName()?uncap_first}.id }}
      </#if>
      </p>
    </div>
  
    <div class="modal-footer">
      <button type="button" class="btn btn-secondary" data-dismiss="modal" (click)="cancel()">
        &nbsp;<span>Cancel</span>
      </button>
  
      <button id="jhi-confirm-delete-${class.getName()}" data-cy="entityConfirmDeleteButton" type="submit" class="btn btn-danger">
        &nbsp;<span>Delete</span>
      </button>
    </div>
  </form>