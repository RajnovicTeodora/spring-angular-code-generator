<#list referenceProperties as property>
  <#if (property.upper)?has_content && property.upper == 1>
import { ${property.name?cap_first} } from "./${property.name}";
  </#if>
</#list>

export class ${class.name} {
  <#list primitiveProperties as property>
    <#if property.upper == 1>
      ${property.name}: ${property.type};
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

  constructor(
    <#list referenceProperties as property>
      <#if property.upper == 1>
        ${property.name}: ${property.type},
      </#if>
    </#list>
    <#list primitiveProperties as property>
      <#if property.upper == 1>
        ${property.name}: ${property.type},
      <#elseif property.upper == -1>
        ${property.name}: ${property.type}[],
      <#else>
        <#list 1..property.upper as i>
          ${property.name}${i}: ${property.type},
        </#list>
      </#if>
    </#list>
  ) {
    <#list referenceProperties as property>
      <#if property.upper == 1>
      this.${property.name} = ${property.name};
      </#if>
    </#list>
    <#list primitiveProperties as property>
      this.${property.name} = ${property.name};
    </#list>
  }
}
