<#assign hasIdProperty = false>
<#assign idName = "">
<#assign idType = "">
<#list class.primitiveProperties as prim>
  <#if prim.isId>
    <#assign hasIdProperty = true>
    <#assign idName = prim.name>
    <#assign idType = prim.type>
  </#if>
</#list>
package ${class.typePackage}.controller;

import ${class.typePackage}.model.${class.name};
import ${class.typePackage}.service.${class.name}Service;

import org.springframework.http.HttpStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping(value = "/api/${class.name?uncap_first}")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class ${class.name}Controller {

	@Autowired
	private ${class.name}Service ${class.name?uncap_first}Service;


	@GetMapping
	public ResponseEntity<List<${class.name}>> findAll() {
		return ResponseEntity.ok().body(${class.name?uncap_first}Service.findAll());
	}

	@GetMapping("/{<#if hasIdProperty>${idName?uncap_first}<#else>id</#if>}")
	public ResponseEntity<${class.name}> findOne(@PathVariable <#if hasIdProperty>${idType} ${idName?uncap_first}<#else>Long id</#if>) {
		Optional<${class.name}> ${class.name?uncap_first} = ${class.name?uncap_first}Service.findOne(<#if hasIdProperty>${idName?uncap_first}<#else>id</#if>);
		return ${class.name?uncap_first}.map(ResponseEntity::ok).orElseGet(() -> new ResponseEntity<>(HttpStatus.NOT_FOUND));
	}

	@PostMapping
	public ResponseEntity<${class.name}> post(@RequestBody ${class.name} ${class.name?uncap_first}) {
		if (${class.name?uncap_first}.get<#if hasIdProperty>${idName?cap_first}<#else>Id</#if>() != 0) {
			return ResponseEntity.badRequest().build();
		}
		
		${class.name?uncap_first} = ${class.name?uncap_first}Service.save(${class.name?uncap_first});
		if (${class.name?uncap_first} == null)
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);	
			
		return new ResponseEntity<>(${class.name?uncap_first}, HttpStatus.CREATED);
	}

	@PutMapping("/{<#if hasIdProperty>${idName?uncap_first}<#else>id</#if>}")
	public ResponseEntity<${class.name}> put(@PathVariable <#if hasIdProperty>${idType} ${idName?uncap_first}<#else>Long id</#if>, @RequestBody ${class.name} ${class.name?uncap_first}) {
		if (<#if hasIdProperty>${idName?uncap_first}<#else>id</#if> != ${class.name?uncap_first}.get<#if hasIdProperty>${idName?cap_first}<#else>Id</#if>()) {
			return ResponseEntity.badRequest().build();
		}
	
		${class.name?uncap_first} = ${class.name?uncap_first}Service.save(${class.name?uncap_first});
		return ${class.name?uncap_first} != null ? ResponseEntity.ok(${class.name?uncap_first}) : ResponseEntity.badRequest().build();
	}

	@DeleteMapping("/{<#if hasIdProperty>${idName?uncap_first}<#else>id</#if>}")
	public ResponseEntity<?> deleteOne(@PathVariable <#if hasIdProperty>${idType} ${idName?uncap_first}<#else>Long id</#if>) {
		${class.name?uncap_first}Service.delete(<#if hasIdProperty>${idName?uncap_first}<#else>id</#if>);
		return ResponseEntity.noContent().build();
	}

}
