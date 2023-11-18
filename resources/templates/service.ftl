package com.diplomski.myapp.service.impl;

import com.diplomski.myapp.domain.${class.name};
import com.diplomski.myapp.repository.${class.name}Repository;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
<#list class.properties as property>
 <#if property.type != "String" || property.type != "boolean" || property.type != "int" || property.type != "double" || property.type != "short" || property.type != "long" || property.type != "char">
import com.diplomski.myapp.service.${property.type}Service;
</#if>
</#list>

@Service
@Transactional
public class ${class.name}Service  {

    private final ${class.name}Repository ${class.name?uncap_first}Repository; 

    public ${class.name}Service(
        ${class.name}Repository ${class.name?uncap_first}Repository,
        <#list class.properties as property>
 <#if property.type != "String" || property.type != "boolean" || property.type != "int" || property.type != "double" || property.type != "short" || property.type != "long" || property.type != "char">
        ${property.type}Service ${property.name?uncap_first}Service,
	</#if>        
</#list>
    ) {
        this.${class.name?uncap_first}Repository = ${class.name?uncap_first}Repository;
        <#list class.properties as property>
 <#if property.type != "String" || property.type != "boolean" || property.type != "int" || property.type != "double" || property.type != "short" || property.type != "long" || property.type != "char">
        this.${property.name?uncap_first}Service = ${property.name?uncap_first}Service;
</#if>        
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
            .findById(${class.name?uncap_first}.getId())
            .map(existing${class.name} -> {
            
            <#list class.properties as property>
			    if (${class.name?uncap_first}.get${property?cap_first}() != null) {
			        existing${class.name}.set${property?cap_first}(${class.name?uncap_first}.get${property?cap_first}());
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
            if(!existing${class.name}.get${property?cap_first}().getClass().isPrimitive()){
                <#if property.type != "List">
                ${property.name}Service.delete(existing${class.name}.get${property.name?cap_first}().getId());
                </#if>
                <#if property.type == "List">
    for (${property.genericType} ${property.name?uncap_first} : existing${class.name}.get${property?cap_first}()) {
        ${property.name}Service.delete(${property.name?uncap_first}.getId());
    }
</#if>
	
            }
        </#list>

        ${class.name?uncap_first}Repository.save(existing${class.name});
    }
}
}
