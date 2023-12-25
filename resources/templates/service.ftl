<#assign hasIdProperty = false>
<#assign idName = "id">
<#assign idType = "long">
<#list class.primitiveProperties as prim>
  <#if prim.isId>
    <#assign hasIdProperty = true>
    <#assign idName = prim.name>
    <#assign idType = prim.type>
  </#if>
</#list>
package ${class.getTypePackage()}.service;

import java.util.ArrayList;
import ${class.getTypePackage()}.repository.${class.getName()}Repository;
import ${class.getTypePackage()}.model.${class.getName()?cap_first};
<#list class.referenceProperties as p>
<#if p.upper == -1>
import ${class.getTypePackage()}.model.${p.type?cap_first};
</#if>
</#list>
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
	   
<#list class.referenceProperties as property>
 import ${class.getTypePackage()}.repository.${property.type}Repository;
</#list>
@Service
@Transactional
public class ${class.name}Service  {

    private final ${class.name}Repository ${class.name?uncap_first}Repository;
    <#list class.referenceProperties as property>
     private final ${property.type}Repository ${property.type?uncap_first}Repository;
		</#list> 

    public ${class.name}Service(
        ${class.name}Repository ${class.name?uncap_first}Repository <#list class.referenceProperties as property>,${property.type}Repository ${property.name?uncap_first}Repository   
		</#list>
    ) {
        this.${class.name?uncap_first}Repository = ${class.name?uncap_first}Repository;
        <#list class.referenceProperties as property>
         this.${property.type?uncap_first}Repository = ${property.name?uncap_first}Repository;      
</#list>
    }
    
    public ${class.name} save(${class.name} ${class.name?uncap_first}) {
        return ${class.name?uncap_first}Repository.save(${class.name?uncap_first});
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
            
            <#list class.primitiveProperties as property>
            	<#if property.type == "String" || property.type=="char">
			    if (${class.name?uncap_first}.get${property.name?cap_first}() != null) {
			    <#elseif property.type == "boolean">
			    if (${class.name?uncap_first}.get${property.name?cap_first}() != false) {
			    <#else>
			     if (${class.name?uncap_first}.get${property.name?cap_first}() != 0) {
			     </#if>
			        existing${class.name}.set${property.name?cap_first}(${class.name?uncap_first}.get${property.name?cap_first}());
			    }
			</#list>

                return existing${class.name};
            })
            .map(${class.name?uncap_first}Repository::save);
    }

    @Transactional(readOnly = true)
    public List<${class.name}> findAll() {
        return ${class.name?uncap_first}Repository.findAll();
    }


    @Transactional(readOnly = true)
    public Optional<${class.name}> findOne(Long id) {
        return ${class.name?uncap_first}Repository.findById(id);
    }

                   
public void delete(Long id) {
    Optional<${class.name}> maybe${class.name?cap_first} = ${class.name?uncap_first}Repository.findById(id);

    if (maybe${class.name?cap_first}.isPresent()) {
		${class.name?cap_first} existing${class.name?cap_first} = maybe${class.name?cap_first}.get();
        existing${class.name?cap_first}.setDeleted(true);
        <#list class.referenceProperties as property>
            if(!existing${class.name?cap_first}.get${property.name?cap_first}().getClass().isPrimitive()){
                <#if property.upper == -1>
                for (${property.type} p: existing${class.getName()?cap_first}.get${property.name?cap_first}()){
                    p.setDeleted(true);
                }
                <#else>
                existing${class.name?cap_first}.get${property.type?cap_first}().setDeleted(true);
</#if>
	
            }
        </#list>

        ${class.name?uncap_first}Repository.save(existing${class.name});
    }
}

<#list referenceProperties as prop>
	<#if prop.upper ==-1>
	public Object find${prop.name?cap_first}Of${class.getName()?cap_first}(${idType} ${idName}) {
        Optional<${class.getName()?cap_first}> ${class.getName()?uncap_first}=${class.getName()?uncap_first}Repository.findById(${idName});
        if(${class.getName()?uncap_first}.isPresent()){
        return  ${class.getName()?uncap_first}.get().get${prop.name?cap_first}()!=null ? ${class.getName()?uncap_first}.get().get${prop.name?cap_first}().toArray() :new ArrayList<>();
        }
        return new ArrayList<>();
    }
	</#if>
	</#list>
}
