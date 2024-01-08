<#assign hasIdProperty = false>
<#assign idName = "id">
<#list primitiveProperties as prim>
  <#if prim.isId>
    <#assign hasIdProperty = true>
    <#assign idName = prim.name>
  </#if>
</#list>
import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute } from '@angular/router';
import { ${class.name}Service } from '../../shared/service/${class.name}/${class.name}.service';
<#list properties as property>
    <#if property.class.name == "myplugin.generator.fmmodel.FMReferenceProperty">
  	<#if property.upper == -1>
  	import { ${property.type?cap_first} } from '../../shared/model/${property.type?cap_first}';
  	<#else>
import { ${property.name?cap_first} } from '../../shared/model/${property.name?cap_first}';
    </#if>
    </#if>
</#list>
import { ${class.name?cap_first}} from '../../shared/model/${class.name?cap_first}';


@Component({
  selector: 'app-${class.name?uncap_first}-view',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './${class.name?cap_first}-view.component.html',
  styleUrl: './${class.name?cap_first}-view.component.scss'
})
export class ${class.name}ViewComponent implements OnInit{
  isEditMode: boolean = false;
  <#list referenceProperties as property>
    
    	<#if property.upper == -1>
        ${property.name?uncap_first}: any = null
        <#else>
        ${property.name?uncap_first}: ${property.name?cap_first}[] = []
        </#if>
    
  </#list>
  <#list primitiveProperties as property>
      <#if property.type == "int" || property.type == "long" || property.type == "Integer" || property.type == "float" || property.type == "Double" || property.type == "double" >
    	${property.name?uncap_first}: number = 0; 
    <#elseif property.type == "String" || property.type == "char">
    	${property.name?uncap_first}: string = ""; 
    <#elseif property.type == "boolean">
    	${property.name?uncap_first}: boolean = false; 
    <#elseif property.frontType == "string">
    	${property.name?uncap_first}: ${property.frontType} = "";
    <#else>
    	${property.name?uncap_first}: ${property.type?uncap_first} = ""; 
    </#if>
  </#list>
  <#if !hasIdProperty>
  		id: number = 0;
  <#else>
  		id: any;	
  </#if>
  constructor(
    private route: ActivatedRoute,
    private service: ${class.name}Service
  ) {}

  ngOnInit(): void {
    this.checkEditMode();
  }

  private checkEditMode(): void {
    this.route.params.subscribe((params) => {
      if (params['id']) { ///todo ili ovde da ide nest sto nije id, tipa indeks da je id
        const ${class.name?uncap_first}Id = params['id'];
  		this.id = params['id'];
        this.fetch${class.name}Data(${class.name?uncap_first}Id);
      }
    });
  }

  private fetch${class.name}Data(${class.name?uncap_first}Id: number): void {
    this.service.findById(${class.name?uncap_first}Id).then((${class.name?uncap_first}Data: any) => {
       <#list primitiveProperties as property>
        this.${property.name?uncap_first} = ${class.name?uncap_first}Data.${property.name?uncap_first};
      </#list>
      <#list referenceProperties as prop>
      <#if prop.upper == -1>
       this.service.find${prop.name?cap_first}By${class.getName()?cap_first}${idName?cap_first}(this.${idName?uncap_first}).then((${prop.name?uncap_first}: any)=>{
      this.${prop.name} = ${prop.name};
  		});
  	  </#if>
      </#list>
    });
  }
  getHeader(prototpe: any): any {
    if (prototpe) return Object.keys(prototpe);
  }

  public getObjectProperties(obj: any): any {
    if (obj) {
      return Object.keys(obj).map((key) => {
        if (Object(obj[key]) === obj[key]) {
          return obj[key].id;
        }
        return obj[key];
      });
    }
  }

}
