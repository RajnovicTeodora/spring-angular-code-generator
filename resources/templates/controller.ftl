package ${class.typePackage}.controller;

import ${class.typePackage}.model.${class.name};
import ${class.typePackage}.dto.${class.name}DTO;
import ${class.typePackage}.service.${class.name}Service;
import ${class.typePackage}.mapper.${class.name}Mapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(value = "/api/${class.name?uncap_first}")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class ${class.name}Controller {

	@Autowired
	private ${class.name}Service ${class.name?uncap_first}Service;

	@Autowired
	private ${class.name}Mapper ${class.name?uncap_first}Mapper;

	@GetMapping
	public ResponseEntity<List<${class.name}DTO>> findAll() {
		List<${class.name}> ${class.name?uncap_first}s = ${class.name?uncap_first}Service.findAll();
		return ResponseEntity.ok().body(${class.name?uncap_first}Mapper.toDto(${class.name?uncap_first}s));
	}

	@GetMapping("/{id}")
	public ResponseEntity<${class.name}DTO> findOne(@PathVariable Long id) {
		return ResponseEntity.ok(${class.name?uncap_first}Mapper.toDto(${class.name?uncap_first}Service.findOne(id)));
	}

	@PostMapping
	public ResponseEntity<${class.name}DTO> post(@RequestBody ${class.name}DTO dto) {
		if (dto.getId() != null && dto.getId() != 0) {
			return ResponseEntity.badRequest().build();
		}
		${class.name} ${class.name?uncap_first} = ${class.name?uncap_first}Mapper.toEntity(dto);
		${class.name?uncap_first} = ${class.name?uncap_first}Service.save(${class.name?uncap_first});
		if (${class.name?uncap_first} == null)
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);	
			
		return new ResponseEntity<>(${class.name?uncap_first}Mapper.toDto(${class.name?uncap_first}), HttpStatus.CREATED);
	}

	@PutMapping("/{id}")
	public ResponseEntity<${class.name}DTO> put(@PathVariable Long id, @RequestBody ${class.name}DTO dto) {
		if (id != dto.getId()) {
			return ResponseEntity.badRequest().build();
		}
		${class.name} ${class.name?uncap_first} = ${class.name?uncap_first}Mapper.toEntity(dto);
		${class.name?uncap_first} = ${class.name?uncap_first}Service.save(${class.name?uncap_first});
		return ${class.name?uncap_first} != null ? ResponseEntity.ok(${class.name?uncap_first}Mapper.toDto(${class.name?uncap_first})) : ResponseEntity.badRequest().build();
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<?> deleteOne(@PathVariable Long id) throws Exception {
		List<${class.name}> ${class.name?uncap_first} = ${class.name?uncap_first}Service.findOne(id);
		${class.name?uncap_first}Service.remove(${class.name?uncap_first});
		return ResponseEntity.noContent().build();
	}

}
