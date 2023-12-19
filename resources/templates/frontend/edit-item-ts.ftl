import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import {
  FormBuilder,
  FormGroup,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { ${class.getName()?cap_first}Service } from '../../shared/service/${class.getName()?cap_first}/${class.getName()?cap_first}.service';
<#list properties as property>
    <#if property.class.name == "myplugin.generator.fmmodel.FMReferenceProperty">
    <#if property.upper == 1>
import { ${property.getName()?cap_first} } from '../../shared/model/${property.getName()?cap_first}';
<#elseif property.upper == -1>
import { ${property.type?cap_first} } from '../../shared/model/${property.type?cap_first}';
</#if>
    </#if>
</#list>
 import { ${class.getName()?cap_first} } from '../../shared/model/${class.getName()}';

@Component({
  selector: 'app-${class.getName()?uncap_first}-edit',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './${class.getName()?cap_first}-edit.component.html',
  styleUrl: './${class.getName()?cap_first}-edit.component.scss',
})
export class ${class.getName()}EditComponent implements OnInit {
  ${class.getName()?uncap_first}Form!: FormGroup;
  isEditMode: boolean = false;
    <#list primitiveProperties as property>
    <#if property.type == "int" || property.type == "Integer" || property.type == "float" || property.type == "Double" || property.type == "double" >
        ${property.name?uncap_first}: number = 0;
    <#elseif property.type == "String" || property.type == "char">
    	${property.name?uncap_first}: string = "";
    <#elseif property.type == "boolean">
    	${property.name?uncap_first}: boolean = false;
    </#if>
  </#list>
   <#list referenceProperties as property>
        ${property.name?uncap_first}: ${property.type?cap_first}[] = [];
  </#list>

  constructor(
    private fb: FormBuilder,
    private route: ActivatedRoute,
    private service: ${class.getName()}Service
  ) {}

  ngOnInit(): void {
    this.initializeForm();
    this.checkEditMode();
  }

  private initializeForm(): void {
    this.${class.getName()?uncap_first}Form = this.fb.group({
    <#list properties as property>
        <#if property.class.name != "myplugin.generator.fmmodel.FMReferenceProperty">
            ${property.name}: ['', Validators.required],
        </#if>
    </#list>
    });
  }

  private checkEditMode(): void {
    this.route.params.subscribe((params) => {
      if (params['id']) {
        const ${class.getName()?uncap_first}Id = params['id'];
        this.isEditMode = true;
       // this.fetchStudentData(studentId);
      }
    });
  }

  private fetch${class.getName()}Data(${class.getName()?uncap_first}Id: number): void {
    this.service.findById(${class.getName()?uncap_first}Id).then((${class.getName()?uncap_first}Data: any) => {
      //this.grades = ${class.getName()?uncap_first}Data.grades;
     // this.${class.getName()?uncap_first}Form.patchValue({
        <#list properties as property>
            <#if property.class.name != "myplugin.generator.fmmodel.FMReferenceProperty">
               // this.fetch${class.getName()}Data.(${property.name});
            </#if>
        </#list>
    //  });
    });
  }

  onSubmit(): void {
    if (this.${class.getName()?uncap_first}Form.valid) {
      const formData = this.${class.getName()?uncap_first}Form.value;
      if (this.isEditMode) {
        // Handle update logic using ${class.getName()}Service
        // Update ${class.getName()?uncap_first} data with formData
        // this.${class.getName()?uncap_first}Service.update${class.getName()}(formData).subscribe(...);
        console.log('Updating ${class.getName()?uncap_first}:', formData);
      } else {
        // Handle creation logic using ${class.getName()}Service
        // Create new ${class.getName()?uncap_first} with formData
        // this.${class.getName()?uncap_first}Service.create${class.getName()}(formData).subscribe(...);
        console.log('Creating ${class.getName()?uncap_first}:', formData);
      }
    }
  }
  <#list referenceProperties as property>
   public getObjectProperties${property.name?cap_first}(${property.name?uncap_first}: ${property.type?cap_first}): any {
    return Object.keys(${property.name?uncap_first});
  }
  </#list>
}
