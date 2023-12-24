<#assign hasId = false>
<#assign hasEnum = false>
<#assign hasRefProp = false>
<#assign filteredRefProps = []>
<#list referenceProperties as property>
	<#if (property)?? && (property.upper)?? && (property.cardinality)?? && (property.cardinality == "OneToOne" || property.cardinality == "ManyToOne")>
	   <#assign filteredRefProps = filteredRefProps + [ property.name ]>
	   <#assign hasRefProp = true>
	</#if>
</#list>
<#list primitiveProperties as prim>
  <#if prim.isId>
    <#assign hasId = true>
  </#if>
  <#if prim.isEnum>
    <#assign hasEnum = true>
  </#if>
</#list>
<#lt>package ${class.typePackage}.mapper;

<#if hasEnum == true>import ${class.typePackage}.enumeration.*;</#if>
import ${class.typePackage}.model.*;
import ${class.typePackage}.dto.*;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class ${class.name?cap_first}Mapper {
	<#if hasRefProp == true>
	
	<#list filteredRefProps as property>
	private final ${property?cap_first}Mapper ${property?lower_case}Mapper;
	</#list>	
	
	public ${class.name?cap_first}Mapper(<#list filteredRefProps as property> ${property?cap_first}Mapper ${property?lower_case}Mapper<#if !property?is_last>,</#if></#list>) {
        <#list filteredRefProps as property>
        this.${property?lower_case}Mapper = ${property?lower_case}Mapper;
        </#list>
    }
    
    </#if>
	public ${class.name?cap_first} toModel(${class.name?cap_first}DTO dto) {
        return ${class.name?cap_first}.builder()<#if hasId == false>${'\n'}	        		.id(dto.getId()) </#if>
        		<#list primitiveProperties as property>
	        		.${property.name?lower_case}(<#rt> 
	        		<#if property.type == "boolean"><#lt>dto.is${property.name?cap_first}())
	        		<#elseif property.isEnum == true><#lt>${property.type}.valueOf(dto.get${property.name?cap_first}()))
	        		<#else><#lt>dto.get${property.name?cap_first}())
	        		</#if>
        		</#list>
        		<#if hasRefProp == true>
        		<#list filteredRefProps as property>
	        		.${property?lower_case}(${property?lower_case}Mapper.toModel(dto.get${property?cap_first}()))
				</#list>
				</#if>
                .build();
    }
    
    public ${class.name?cap_first}DTO toDto(${class.name?cap_first} model) {
        return ${class.name?cap_first}DTO.builder()<#if hasId == false>${'\n'}	        		.id(model.getId()) </#if>
        		<#list primitiveProperties as property>
        			.${property.name?lower_case}(model.<#rt> 
	        		<#if property.type == "boolean"><#lt>is${property.name?cap_first}())
	        		<#elseif property.isEnum == true><#lt>get${property.name?cap_first}().name())
	        		<#else><#lt>get${property.name?cap_first}())
        			</#if>
        		</#list>
        		<#if hasRefProp == true>
        			<#list filteredRefProps as property>
	        		.${property?lower_case}(${property?lower_case}Mapper.toDTO(model.get${property?cap_first}()))
					</#list>
				</#if>
                .build();
    }
    
    public List<${class.name?cap_first}DTO> toDto(List<${class.name?cap_first}> models) {
        return models.stream().map(this::toDto).collect(Collectors.toList());
    }

}
