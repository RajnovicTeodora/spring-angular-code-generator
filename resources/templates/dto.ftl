<#assign hasId = false>
<#assign hasType = "long">
<#list primitiveProperties as prim>
  <#if prim.isId>
    <#assign hasId = true>
    <#assign hasType = prim.type>
  </#if>
</#list>
<#lt>package ${class.typePackage}.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ${class.name}DTO {
	<#if hasId == false>${'\n'}    private long id;<#else> private ${hasType} id;</#if>
	<#list primitiveProperties as property>
	<#if (property)??> 
	private <#if property.isEnum == true>String<#else>${property.type}</#if> ${property.name?uncap_first};
	</#if>
	</#list>
	<#assign added = false>
	<#list referenceProperties as property>
	<#if (property)?? && (property.upper)?? && (property.cardinality)?? && (property.cardinality == "OneToOne" || property.cardinality == "ManyToOne")>private ${property.type}DTO ${property.name?uncap_first};
	<#assign added = true>
	</#if>
	</#list>
	
	<#if added>
	public ${class.name}DTO(<#if hasId>${hasType} id, <#else> long id,</#if><#list primitiveProperties as prop> <#if prop.isEnum == true>String<#else>${prop.type}</#if> ${prop.name?uncap_first}<#if prop?has_next>,</#if></#list>){
		<#list primitiveProperties as prop>
		this.${prop.name?uncap_first} = ${prop.name?uncap_first};
		</#list>
		this.id = id;
		
	}
	</#if>
}