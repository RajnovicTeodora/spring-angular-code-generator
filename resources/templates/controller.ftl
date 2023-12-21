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

	@GetMapping("/{id}")
	public ResponseEntity<${class.name}> findOne(@PathVariable Long id) {
		Optional<${class.name}> ${class.name?uncap_first} = ${class.name?uncap_first}Service.findOne(id);
		return ${class.name?uncap_first}.map(ResponseEntity::ok).orElseGet(() -> new ResponseEntity<>(HttpStatus.NOT_FOUND));
	}

	@PostMapping
	public ResponseEntity<${class.name}> post(@RequestBody ${class.name} ${class.name?uncap_first}) {
		if (${class.name?uncap_first}.getId() != 0) {
			return ResponseEntity.badRequest().build();
		}
		
		${class.name?uncap_first} = ${class.name?uncap_first}Service.save(${class.name?uncap_first});
		if (${class.name?uncap_first} == null)
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);	
			
		return new ResponseEntity<>(${class.name?uncap_first}, HttpStatus.CREATED);
	}

	@PutMapping("/{id}")
	public ResponseEntity<${class.name}> put(@PathVariable Long id, @RequestBody ${class.name} ${class.name?uncap_first}) {
		if (id != ${class.name?uncap_first}.getId()) {
			return ResponseEntity.badRequest().build();
		}
	
		${class.name?uncap_first} = ${class.name?uncap_first}Service.save(${class.name?uncap_first});
		return ${class.name?uncap_first} != null ? ResponseEntity.ok(${class.name?uncap_first}) : ResponseEntity.badRequest().build();
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<?> deleteOne(@PathVariable Long id) {
		${class.name?uncap_first}Service.delete(id);
		return ResponseEntity.noContent().build();
	}

}
