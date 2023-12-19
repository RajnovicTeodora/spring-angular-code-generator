<#assign hasIdProperty = false>
<#list primitiveProperties as prim>
  <#if prim.isId>
    <#assign hasIdProperty = true>
    <#assign idName = prim.name>
  </#if>
</#list>


<#list referenceProperties as property>
  <#if (property.upper)?has_content && property.upper == 1>
import { ${property.name?cap_first} } from "./${property.name?cap_first}";
  </#if>
</#list>

export class ${class.name} {
  <#list primitiveProperties as property>
    <#if property.upper == 1>
    
      <#if property.type == "int" || property.type == "long" || property.type == "Integer" || property.type == "float" || property.type == "Double" || property.type == "double" >
    	${property.name?uncap_first}: number = 0; 
     <#elseif property.type == "String" || property.type == "char">
    	${property.name?uncap_first}: string = ""; 
    <#elseif property.type == "boolean">
    	${property.name?uncap_first}: boolean = false; 
    <#else>
    	${property.name?uncap_first}: ${property.type?uncap_first} = ""; 
    </#if>
    <#elseif property.upper == -1>
      ${property.name}: ${property.type}[];
    <#else>
      <#list 1..property.upper as i>
        ${property.name}${i}: ${property.type};
      </#list>
    </#if>
  </#list>

  <#list referenceProperties as property>
    <#if property.upper == 1>
      ${property.name}: ${property.type};
    </#if>
  </#list>
  <#if !hasIdProperty>
  	id: number;
  </#if>

  constructor(
    <#list referenceProperties as property>
      <#if property.upper == 1>
        ${property.name}: ${property.type},
      </#if>
    </#list>
    <#list primitiveProperties as property>
      <#if property.upper == 1>
      	<#if property.type == "int" || property.type == "long" || property.type == "Integer" || property.type == "float" || property.type == "Double" || property.type == "double" >
    	${property.name?uncap_first}: number, 
     <#elseif property.type == "String" || property.type == "char">
    	${property.name?uncap_first}: string, 
    <#elseif property.type == "boolean">
    	${property.name?uncap_first}: boolean, 
    <#else>
    	${property.name?uncap_first}: ${property.type?uncap_first}; 
    </#if>
      <#elseif property.upper == -1>
        ${property.name}: ${property.type}[],
      <#else>
        <#list 1..property.upper as i>
          ${property.name}${i}: ${property.type},
        </#list>
      </#if>
    </#list>
      <#if !hasIdProperty>
  		id: number,
  	</#if>
  ) {
    <#list referenceProperties as property>
      <#if property.upper == 1>
      this.${property.name} = ${property.name};
      </#if>
    </#list>
    <#list primitiveProperties as property>
      this.${property.name} = ${property.name};
    </#list>
     <#if !hasIdProperty>
  	  this.id = id;
  	</#if>
  }
}
