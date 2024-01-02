<#assign hasIdProperty = false>
<#assign idName = "id">
<#assign idType = "number">
<#list primitiveProperties as prim>
  <#if prim.isId>
    <#assign hasIdProperty = true>
    <#assign idName = prim.name>
    <#assign idType = prim.frontType>
  </#if>
</#list>


<#list referenceProperties as property>
  <#if (property.upper)?has_content && property.upper == 1>
import { ${property.name?cap_first} } from "./${property.name?cap_first}";
  <#else>
import { ${property.type?cap_first} } from "./${property.type?cap_first}";
  </#if>
</#list>

export class ${class.name} {
	
<#if hasIdProperty && idName!="id"> id: ${idType};</#if>
  <#list primitiveProperties as property>
    <#if property.upper == 1>
    
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
    <#elseif property.upper == -1>
      ${property.name}: ${property.type}[]=[];
    <#else>
      <#list 1..property.upper as i>
        ${property.name}${i}: ${property.type};
      </#list>
    </#if>
  </#list>

  <#list referenceProperties as property>
    <#if property.upper == -1>
      ${property.name}: ${property.type}[] | null;
    <#else> 
    ${property.name}: ${property.type} | null;
    </#if>
  </#list>
  <#if !hasIdProperty>
  	id: number;
  </#if>
  [key: string]: any;

  constructor(
    <#list primitiveProperties as property>
      <#if property.upper == 1>
      	<#if property.type == "int" || property.type == "long" || property.type == "Integer" || property.type == "float" || property.type == "Double" || property.type == "double" >
    	${property.name?uncap_first}: number, 
     <#elseif property.type == "String" || property.type == "char">
    	${property.name?uncap_first}: string, 
    <#elseif property.type == "boolean">
    	${property.name?uncap_first}: boolean, 
    <#else>
    	${property.name?uncap_first}: ${property.frontType?uncap_first}, 
    </#if>
      <#elseif property.upper == -1>
        ${property.name}: ${property.type}[] | null,
      <#else>
        <#list 1..property.upper as i>
          ${property.name}${i}: ${property.type},
        </#list>
      </#if>
    </#list>
    <#list referenceProperties as property>
     <#if property.upper == -1>
        ${property.name}: ${property.type}[] | null,
      <#else>
        ${property.name}: ${property.type} | null,
      </#if>
    </#list>
      <#if !hasIdProperty>
  		id: number,
  	</#if>
  ) {
    <#list referenceProperties as property>
      <#if property.upper == 1>
      this.${property.name} = ${property.name};
      <#else>
      this.${property.name} = ${property.name};
      </#if>
    </#list>
    <#list primitiveProperties as property>
      this.${property.name} = ${property.name};
    </#list>
     <#if !hasIdProperty>
  	  this.id = id;
  	</#if>
  	<#if hasIdProperty && idName!="id"> this.id=${idName};</#if>
  }
}
