<#assign hasId = false>
<#assign hasEnum = false>
<#assign hasRefProp = false>
<#assign idName = "id">
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
    <#assign idName = prim.name>
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
	 public ${class.name?cap_first}DTO toDTO(${class.name?cap_first} model) {
        ${class.name?cap_first}DTO dto = new ${class.name?cap_first}DTO();
        <#list primitiveProperties as property>
        <#if property.isEnum>
        dto.set${property.name?cap_first}(model.get${property.name?cap_first}().toString());
        <#else>
        dto.set${property.name?cap_first}(model.get${property.name?cap_first}());
        </#if>
        
        </#list>
        <#if hasId>
        	dto.setId(model.get${idName?cap_first}());
        <#else>
        dto.setId(model.getId());
        </#if>

        <#list referenceProperties as property>
        <#if property.upper != -1>
        if(model.get${property.name?cap_first}()!=null){
        dto.set${property.name?cap_first}(${property.name?uncap_first}Mapper.toDTO(model.get${property.name?cap_first}()));}
        </#if>
        </#list>

        return dto;
    }

}
