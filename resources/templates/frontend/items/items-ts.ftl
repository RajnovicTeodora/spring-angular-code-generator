<#assign identifierType = 'number'>
<#list primitiveProperties as property>
  <#if property.isId>
    <#assign identifierType = property.frontType>
  </#if>
</#list>

import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ${class.name?cap_first}Service } from '../../shared/service/${class.name}/${class.name}.service';
import { ${class.name?cap_first} } from '../../shared/model/${class.name}';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faAdd, faInfo } from '@fortawesome/free-solid-svg-icons';
import { Router } from '@angular/router';
import { ${class.name?cap_first}DeleteComponent } from '../${class.name?cap_first}-delete/${class.name?cap_first}-delete.component';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';

@Component({
  selector: 'app-${class.name?lower_case}s',
  standalone: true,
  imports: [CommonModule, FontAwesomeModule],
  templateUrl: './${class.name?cap_first}s.component.html',
  styleUrl: './${class.name?cap_first}s.component.scss',
})
export class ${class.name?cap_first}sComponent implements OnInit {
  ${class.name?lower_case}s: ${class.name?cap_first}[] = [];
  faInfo = faInfo;
  faAdd = faAdd;

  constructor(
    private service: ${class.name?cap_first}Service,
    private router: Router,
    protected modalService: NgbModal) {}

  ngOnInit(): void {
    this.initializeData();
  }

  async initializeData() {
    this.${class.name?lower_case}s = await this.service.findAll();
  }

  open(id: ${identifierType}) {
    this.router.navigate(['${class.name?lower_case}', id]);
  }

  create() {
    this.router.navigate(['${class.name?lower_case}', 'new']);
  }
  delete(${class.name?lower_case}: ${class.name?cap_first}): void {
    const modalRef = this.modalService.open(${class.name?cap_first}DeleteComponent, { size: 'lg', backdrop: 'static' });
    modalRef.componentInstance.${class.name?lower_case} = ${class.name?lower_case};
    modalRef.closed.subscribe(reason => {
      if (reason === 'deleted') {
        //this.loadPage(); neki refresh
      }
    });
  }
  view(id: ${identifierType}) {
    this.router.navigate(['${class.name?lower_case}/view/', id]);
  }
}
