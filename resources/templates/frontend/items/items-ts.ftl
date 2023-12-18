<#assign identifierType = 'number'>
<#list primitiveProperties as property>
  <#if property.generationType?exists && property.generationType != null>
    <#if property.isId>
      <#if property.type == "String" || property.type != "char">
        <#assign identifierType = 'string'>
      </#if>
    </#if>
  </#if>
</#list>

import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ${class.name?cap_first}Service } from '../../shared/service/${class.name?lower_case}/${class.name?lower_case}.service';
import { ${class.name?cap_first} } from '../../shared/model/${class.name?lower_case}';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faAdd, faInfo } from '@fortawesome/free-solid-svg-icons';
import { Router } from '@angular/router';
import { ${class.name?cap_first}DeleteComponent } from '../${class.name?lower_case}-delete/${class.name?lower_case}-delete.component';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';

@Component({
  selector: 'app-${class.name?lower_case}s',
  standalone: true,
  imports: [CommonModule, FontAwesomeModule],
  templateUrl: './${class.name?lower_case}s.component.html',
  styleUrl: './${class.name?lower_case}s.component.scss',
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
    this.router.navigate(['${class.name?lower_case}s', id]);
  }

  create() {
    this.router.navigate(['${class.name?lower_case}s', 'new']);
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
    this.router.navigate(['${class.name?lower_case}s/view/', id]);
  }
}
