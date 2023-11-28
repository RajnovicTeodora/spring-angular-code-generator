import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute } from '@angular/router';
import { ${class.name}Service } from '../../shared/service/${class.name?uncap_first}/${class.name?uncap_first}.service';
<#list properties as property>
    <#if property.class.name == "FMReferenceProperty">
        import { ${property.name} } from '../../shared/model/${property.name?uncap_first}';
    </#if>
</#list>

@Component({
  selector: 'app-${class.name?uncap_first}-view',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './${class.name?uncap_first}-view.component.html',
  styleUrl: './${class.name?uncap_first}-view.component.scss'
})
export class ${class.name}ViewComponent implements OnInit{
  isEditMode: boolean = false;
  <#list properties as property>
    <#if property.class.name == "FMReferenceProperty">
        ${property.name?uncap_first}: ${property.name}[] = [];
    <#else>
        //doradi po tipovima
        name: string = "";
        age: string = "";
    </#if>
  </#list>

  constructor(
    private route: ActivatedRoute,
    private service: ${class.name}Service
  ) {}

  ngOnInit(): void {
    this.checkEditMode();
  }

  private checkEditMode(): void {
    this.route.params.subscribe((params) => {
      if (params['id']) { ///todo ili ovde da ide nest sto nije id, tipa indeks da je id
        const ${class.name?uncap_first}Id = params['id'];
        this.isEditMode = true;
        this.fetch${class.name}Data(${class.name?uncap_first}Id);
      }
    });
  }

  private fetch${class.name}Data(${class.name?uncap_first}Id: number): void {
    this.service.findById(${class.name?uncap_first}Id).then((${class.name?uncap_first}Data: any) => {
       <#list properties as property>
        this.${property.name?uncap_first} = ${class.name?uncap_first}Data.${property.name?uncap_first};
      </#list>
    });
  }

}
