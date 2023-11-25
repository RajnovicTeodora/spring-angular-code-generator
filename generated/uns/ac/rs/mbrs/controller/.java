package uns.ac.rs.mbrs.controller.controller;

import uns.ac.rs.mbrs.controller.model.;
import uns.ac.rs.mbrs.controller.dto.DTO;
import uns.ac.rs.mbrs.controller.service.Service;
import uns.ac.rs.mbrs.controller.mapper.Mapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(value = "/api/")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class Controller {

	@Autowired
	private Service Service;

	@Autowired
	private Mapper Mapper;

	@GetMapping
	public ResponseEntity<List<DTO>> findAll() {
		List<> s = Service.findAll();
		return ResponseEntity.ok().body(Mapper.toDto(s));
	}

	@GetMapping("/{id}")
	public ResponseEntity<DTO> findOne(@PathVariable Long id) {
		return ResponseEntity.ok(Mapper.toDto(Service.findOne(id)));
	}

	@PostMapping
	public ResponseEntity<DTO> post(@RequestBody DTO dto) {
		if (dto.getId() != null && dto.getId() != 0) {
			return ResponseEntity.badRequest().build();
		}
		  = Mapper.toEntity(dto);
		 = Service.save();
		if ( == null)
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);	
			
		return new ResponseEntity<>(Mapper.toDto(), HttpStatus.CREATED);
	}

	@PutMapping("/{id}")
	public ResponseEntity<DTO> put(@PathVariable Long id, @RequestBody DTO dto) {
		if (id != dto.getId()) {
			return ResponseEntity.badRequest().build();
		}
		  = Mapper.toEntity(dto);
		 = Service.save();
		return  != null ? ResponseEntity.ok(Mapper.toDto()) : ResponseEntity.badRequest().build();
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<?> deleteOne(@PathVariable Long id) throws Exception {
		List<>  = Service.findOne(id);
		Service.remove();
		return ResponseEntity.noContent().build();
	}

}
