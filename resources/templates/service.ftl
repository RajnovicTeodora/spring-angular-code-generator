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
import ${class.getTypePackage()}.mapper.${p.type?cap_first}Mapper;
import ${class.getTypePackage()}.dto.${p.type?cap_first}DTO;
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
import uns.ac.rs.mbrs.dto.${class.getName()?cap_first}DTO;
<#list class.referenceProperties as property>
 import ${class.getTypePackage()}.repository.${property.type}Repository;
</#list>
@Service
@Transactional
public class ${class.name}Service  {

    private final ${class.name}Repository ${class.name?uncap_first}Repository;
    <#list class.referenceProperties as property>
     private final ${property.type}Repository ${property.type?uncap_first}Repository;
     <#if property.upper ==-1>
       private final ${property.type}Mapper ${property.type?uncap_first}Mapper;
       </#if>
		</#list> 

    public ${class.name}Service(
        ${class.name}Repository ${class.name?uncap_first}Repository <#list class.referenceProperties as property>,${property.type}Repository ${property.name?uncap_first}Repository 
             <#if property.upper ==-1>,${property.type}Mapper ${property.type?uncap_first}Mapper</#if>
		</#list>
    ) {
        this.${class.name?uncap_first}Repository = ${class.name?uncap_first}Repository;
        <#list class.referenceProperties as property>
         this.${property.type?uncap_first}Repository = ${property.name?uncap_first}Repository; 
              <#if property.upper ==-1> 
         this.${property.type?uncap_first}Mapper = ${property.type?uncap_first}Mapper;   
         </#if>
</#list>
    }
    
    public ${class.name}DTO save(${class.name} ${class.name?uncap_first}) {
    	${class.name?cap_first} s = ${class.name?uncap_first}Repository.save(${class.name?uncap_first});
       
    	<#list referenceProperties as prop>
    	<#if prop.upper ==-1>
    	for(${prop.type?cap_first} g : ${class.name?uncap_first}.get${prop.name?cap_first}()){
    	 	${prop.type?cap_first} gr = ${prop.type?uncap_first}Repository.findById(g.getId()).get();
            gr.set${class.getName()?cap_first}(s);
            ${prop.type?uncap_first}Repository.save(gr);
        }
    	</#if>
    	</#list>
    	return new ${class.name?cap_first}DTO(s.get${idName?cap_first}() <#if primitiveProperties?has_content>,</#if> <#list primitiveProperties as prop><#if prop.isEnum>s.get${prop.name?cap_first}().toString()<#else>s.get${prop.name?cap_first}()</#if> <#if prop?has_next>,</#if></#list>);
    }

    public ${class.name}DTO update(${class.name} ${class.name?uncap_first}) {
    
    <#list referenceProperties as prop>
    	<#if prop.upper ==-1>
    	if (${class.name?uncap_first}Repository.findById(${class.name?uncap_first}.get${idName?cap_first}()).isPresent()){
            List<${prop.type?cap_first}> g = ${class.name?uncap_first}Repository.findById(${class.name?uncap_first}.get${idName?cap_first}()).get().get${prop.name?cap_first}();
            if(g!=null){
                for(${prop.type?cap_first} gr : g){
                    gr.set${class.name?cap_first}(null);
                    ${prop.type?uncap_first}Repository.save(gr);
                }
            }
        }
    </#if>
    	</#list>
    
    
    	<#list referenceProperties as prop>
    	<#if prop.upper ==-1>
    	for(${prop.type?cap_first} g : ${class.name?uncap_first}.get${prop.name?cap_first}()){
            g.set${class.name?cap_first}(${class.name?uncap_first});
            ${prop.type?uncap_first}Repository.save(g);
        }
    	</#if>
    	</#list>
    	${class.name?cap_first} s = ${class.name?uncap_first}Repository.save(${class.name?uncap_first});
        return new ${class.name?cap_first}DTO(s.get${idName?cap_first}() <#if primitiveProperties?has_content>,</#if> <#list primitiveProperties as prop><#if prop.frontType == "string" && prop.type!="String" && prop.type!="char">s.get${prop.name?cap_first}().toString()<#else>s.get${prop.name?cap_first}()</#if> <#if prop?has_next>,</#if></#list> );
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
			    <#elseif property.type == "int" ||  property.type == "Integer" || property.type == "double" ||  property.type == "Double"|| property.type == "long" ||  property.type == "float">
			     if (${class.name?uncap_first}.get${property.name?cap_first}() != 0) {
			    <#else>
			    if (${class.name?uncap_first}.get${property.name?cap_first}() != null) {
			     </#if>
			        existing${class.name}.set${property.name?cap_first}(${class.name?uncap_first}.get${property.name?cap_first}());
			    }
			</#list>

                return existing${class.name};
            })
            .map(${class.name?uncap_first}Repository::save);
    }

    @Transactional(readOnly = true)
    public List<${class.name?cap_first}DTO> findAll() {
   		List<${class.name?cap_first}> ${class.name?uncap_first}s = ${class.name?uncap_first}Repository.findAll();
        List<${class.name?cap_first}DTO> dtos = new ArrayList<>();
        for(${class.name?cap_first} s : ${class.getName()?uncap_first}s){
            ${class.name?cap_first}DTO dto = new ${class.name?cap_first}DTO();
	        <#list primitiveProperties as prop>
	        <#if !( prop.type == "int" || prop.type == "long" || prop.type == "Integer" || prop.type == "float" || prop.type == "Double" || prop.type == "double" || prop.type == "String" || prop.type == "char" || prop.type == "boolean")>
	        dto.set${prop.getName()?cap_first}(s.get${prop.getName()?cap_first}().toString());
	        <#else>
	        dto.set${prop.getName()?cap_first}(s.get${prop.getName()?cap_first}());
	        </#if>
	        
	        dto.setId(s.get${idName?cap_first}());
	        
	        </#list>
            dtos.add(dto);
        }
        return dtos;
       
    }


    @Transactional(readOnly = true)
    public ${class.name}DTO findOne(Long id) {
    	${class.name?cap_first} s =  ${class.name?uncap_first}Repository.findById(id).get();
        ${class.name?cap_first}DTO dto = new ${class.name?cap_first}DTO();
        <#list primitiveProperties as prop>
       <#if !( prop.type == "int" || prop.type == "long" || prop.type == "Integer" || prop.type == "float" || prop.type == "Double" || prop.type == "double" || prop.type == "String" || prop.type == "char" || prop.type == "boolean")>
	    dto.set${prop.getName()?cap_first}(s.get${prop.getName()?cap_first}().toString());
        <#else>
        dto.set${prop.getName()?cap_first}(s.get${prop.getName()?cap_first}());
        </#if>
        </#list>
        return dto;
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

          List<${prop.type?cap_first}DTO> dtos = new ArrayList<>();
                for (${prop.type?cap_first} g : ${class.getName()?uncap_first}.get().get${prop.name?cap_first}()){ 
                    ${prop.type?cap_first}DTO dto = ${prop.type?uncap_first}Mapper.toDTO(g);
                    dtos.add(dto);
                }
                return dtos;

                }
        return new ArrayList<>();
    }
	</#if>
	</#list>
}
