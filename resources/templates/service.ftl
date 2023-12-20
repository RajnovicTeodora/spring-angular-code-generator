<#assign hasIdProperty = false>
<#assign idName = "">
<#list class.primitiveProperties as prim>
  <#if prim.isId>
    <#assign hasIdProperty = true>
    <#assign idName = prim.name>
  </#if>
</#list>
package ${class.getTypePackage()}.service;

import ${class.getTypePackage()}.repository.${class.getName()}Repository;
import ${class.getTypePackage()}.model.${class.getName()};
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
	   
<#list class.referenceProperties as property>
 import ${class.getTypePackage()}.service.${property.type}Service;
</#list>
@Service
@Transactional
public class ${class.name}Service  {

    private final ${class.name}Repository ${class.name?uncap_first}Repository;
    <#list class.referenceProperties as property>
     private final ${property.type}Service ${property.type?uncap_first}Service;
		</#list> 

    public ${class.name}Service(
        ${class.name}Repository ${class.name?uncap_first}Repository <#list class.referenceProperties as property>,${property.type}Service ${property.name?uncap_first}Service   
		</#list>
    ) {
        this.${class.name?uncap_first}Repository = ${class.name?uncap_first}Repository;
        <#list class.referenceProperties as property>
         this.${property.type?uncap_first}Service = ${property.name?uncap_first}Service;      
</#list>
    }
    
    public ${class.name} save(${class.name} ${class.name?uncap_first}) {
        return ${class.name?uncap_first}Repository.save(${class.name});
    }

    public ${class.name} update(${class.name} ${class.name?uncap_first}) {
        return ${class.name?uncap_first}Repository.save(${class.name?uncap_first});
    }

	 public Optional<${class.name}> partialUpdate(${class.name} ${class.name?uncap_first}) {

        return ${class.name?uncap_first}Repository
        
        	<#if hasIdProperty>
        	.findById(${class.name?uncap_first}.get${idName?cap_first}())
        	<#else>
        	.findById(${class.name?uncap_first}.getId())
        	</#if>
            .map(existing${class.name} -> {
            
            <#list class.properties as property>
			    if (${class.name?uncap_first}.get${property.name?cap_first}() != null) {
			        existing${class.name}.set${property.name?cap_first}(${class.name?uncap_first}.get${property.name?cap_first}());
			    }
			</#list>

                return existing${class.name};
            })
            .map(${class.name?uncap_first}Repository::save);
    }

    @Transactional(readOnly = true)
    public Page<${class.name}> findAll(Pageable pageable) {
        return ${class.name?uncap_first}Repository.findAll(pageable);
    }


    @Transactional(readOnly = true)
    public Optional<${class.name}> findOne(Long id) {
        return ${class.name?uncap_first}Repository.findById(id);
    }

                   
public void delete(Long id) {
    ${class.name} existing${class.name} = ${class.name?uncap_first}Repository.findById(id);

    if (existing${class.name} != null) {
        existing${class.name}.setDeleted(true);
        <#list class.properties as property>
            if(!existing${class.name}.get${property.name?cap_first}().getClass().isPrimitive()){
                <#if property.type != "List">
                ${property.name}Service.delete(existing${class.name}.get${property.name?cap_first}().getId());
                </#if>
                <#if property.type == "List">
    for (${property.genericType} ${property.name?uncap_first} : existing${class.name}.get${property.name?cap_first}()) {
        ${property.name}Service.delete(${property.name?uncap_first}.getId());
    }
</#if>
	
            }
        </#list>

        ${class.name?uncap_first}Repository.save(existing${class.name});
    }
}
}
