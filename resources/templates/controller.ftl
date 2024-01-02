<#assign hasIdProperty = false>
<#assign idName = "id">
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
import uns.ac.rs.mbrs.dto.${class.getName()?cap_first}DTO;
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
	public ResponseEntity<List<${class.name}DTO>> findAll() {
		return ResponseEntity.ok().body(${class.name?uncap_first}Service.findAll());
	}

	@GetMapping("/{<#if hasIdProperty>${idName?uncap_first}<#else>id</#if>}")
	public ResponseEntity<${class.name}DTO> findOne(@PathVariable <#if hasIdProperty>${idType} ${idName?uncap_first}<#else>Long id</#if>) {
		${class.name}DTO ${class.name?uncap_first} = ${class.name?uncap_first}Service.findOne(<#if hasIdProperty>${idName?uncap_first}<#else>id</#if>);
		return ResponseEntity.ok().body(${class.name?uncap_first});
	}

	@PostMapping
	public ResponseEntity<${class.name}DTO> post(@RequestBody ${class.name} ${class.name?uncap_first}) {
		${class.name}DTO ${class.name?uncap_first}1 = ${class.name?uncap_first}Service.save(${class.name?uncap_first});
		if (${class.name?uncap_first} == null)
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);	
			
		return new ResponseEntity<>(${class.name?uncap_first}1, HttpStatus.CREATED);
	}

	@PutMapping("/{<#if hasIdProperty>${idName?uncap_first}<#else>id</#if>}")
	public ResponseEntity<${class.name}DTO> put(@PathVariable <#if hasIdProperty>${idType} ${idName?uncap_first}<#else>Long id</#if>, @RequestBody ${class.name} ${class.name?uncap_first}) {
	
		${class.name?cap_first}DTO ${class.name?uncap_first}1 = ${class.name?uncap_first}Service.update(${class.name?uncap_first});
		return ${class.name?uncap_first} != null ? ResponseEntity.ok(${class.name?uncap_first}1) : ResponseEntity.badRequest().build();
	}

	@DeleteMapping("/{<#if hasIdProperty>${idName?uncap_first}<#else>id</#if>}")
	public ResponseEntity<?> deleteOne(@PathVariable <#if hasIdProperty>${idType} ${idName?uncap_first}<#else>Long id</#if>) {
		${class.name?uncap_first}Service.delete(<#if hasIdProperty>${idName?uncap_first}<#else>id</#if>);
		return ResponseEntity.noContent().build();
	}
	
	@GetMapping("/d/{<#if hasIdProperty>${idName?uncap_first}<#else>id</#if>}")
	public ResponseEntity<?> deleOne(@PathVariable <#if hasIdProperty>${idType} ${idName?uncap_first}<#else>Long id</#if>) {
		${class.name?uncap_first}Service.delete(<#if hasIdProperty>${idName?uncap_first}<#else>id</#if>);
		return ResponseEntity.noContent().build();
	}
	
	<#list referenceProperties as prop>
	<#if prop.upper ==-1>
	@GetMapping("/get-${prop.name?uncap_first}/{${idName}}")
	public ResponseEntity<?> get${prop.name?cap_first}(@PathVariable long ${idName}) {
		return ResponseEntity.ok().body(${class.getName()?uncap_first}Service.find${prop.name?cap_first}Of${class.getName()?cap_first}(${idName}));
	}
	</#if>
	</#list>
}
