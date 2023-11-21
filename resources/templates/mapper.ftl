package ${class.typePackage}.mapper;

import ${class.typePackage}.model.${class.name?cap_first};
import ${class.typePackage}.dto.${class.name?cap_first}DTO;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class ${class.name?cap_first}Mapper {
	public ${class.name?cap_first} toModel(${class.name?cap_first}DTO dto) {
        return ${class.name?cap_first}.builder()
        		<#list properties as property>
	        		<#if property.type == "boolean">
	        		.${property.name?lower_case}(dto.is${property.name?cap_first}())
	        		<#else>
	        		.${property.name?lower_case}(dto.get${property.name?cap_first}())
	        		</#if> 
        		</#list>
                .build();
    }
    
    public ${class.name?cap_first}DTO toDto(${class.name?cap_first} model) {
        return ${class.name?cap_first}DTO.builder()
        		<#list properties as property>
	        		<#if property.type == "boolean">
	        		.${property.name?lower_case}(model.is${property.name?cap_first}())
	        		<#else>
        			.${property.name?lower_case}(model.get${property.name?cap_first}())
        			</#if> 
        		</#list>
                .build();
    }
    
    public List<${class.name?cap_first}DTO> toDto(List<${class.name?cap_first}> models) {
        return models.stream().map(this::toDto).collect(Collectors.toList());
    }

}
