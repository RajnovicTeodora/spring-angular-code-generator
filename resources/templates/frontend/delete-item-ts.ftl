<#assign hasIdProperty = false>
<#assign idName = "id">
<#list primitiveProperties as prim>
  <#if prim.isId>
    <#assign hasIdProperty = true>
    <#assign idName = prim.name>
  </#if>
</#list>
import { ActivatedRoute, Router } from '@angular/router';
import { Component, OnInit  } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';
import { ${class.getName()} } from '../../shared/model/${class.getName()}';
import { ${class.getName()?cap_first}Service } from '../../shared/service/${class.getName()?cap_first}/${class.getName()?cap_first}.service';

@Component({
  selector: 'app-${class.getName()?uncap_first}-delete',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './${class.getName()}-delete.component.html',
  styleUrl: './${class.getName()}-delete.component.scss'
})
export class ${class.getName()}DeleteComponent implements OnInit{
  ${class.getName()?uncap_first}?: ${class.getName()};

  ngOnInit(): void {
  }
  constructor(
  private router: Router,
    protected ${class.getName()?uncap_first}Service: ${class.getName()}Service, 
    protected activeModal: NgbActiveModal) {}

  cancel(): void {
    this.activeModal.dismiss();
  }

  confirmDelete(id: any): void {
  	const resp =  this.${class.getName()?uncap_first}Service.delete(this.${class.getName()?uncap_first}!.${idName}).then(()=>this.router.navigate(['${class.getName()?uncap_first}']));
    // this.${class.getName()?uncap_first}Service.delete(id).subscribe(() => {
    //   this.activeModal.close('deleted');
    // });
  }

}
