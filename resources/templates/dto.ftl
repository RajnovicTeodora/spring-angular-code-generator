<#assign hasId = false>
<#list primitiveProperties as prim>
  <#if prim.isId>
    <#assign hasId = true>
  </#if>
</#list>
<#lt>package ${class.typePackage}.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.Getter;
import lombok.Setter

@Data
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ${class.name}DTO {
	<#if hasId == false>${'\n'}    private long id; </#if>
	<#list primitiveProperties as property>
	<#if (property)??> 
	private <#if property.isEnum == true>String<#else>${property.type}</#if> ${property.name?uncap_first};
	</#if>
	</#list>
	<#list referenceProperties as property>
	<#if (property)?? && (property.upper)?? && (property.cardinality)?? && (property.cardinality == "OneToOne" || property.cardinality == "ManyToOne")>private ${property.type}DTO ${property.name?uncap_first};</#if>
	</#list>
}