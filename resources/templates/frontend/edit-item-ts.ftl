import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import {
  FormBuilder,
  FormGroup,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { ${class.getName()}Service } from '../../shared/service/${class.getName()?uncap_first}/${class.getName()?uncap_first}.service';
<#list properties as property>
    <#if property.class.name == "myplugin.generator.fmmodel.FMReferenceProperty">
        import { ${property.name} } from '../../shared/model/${property.name?uncap_first}';
    </#if>
</#list>

@Component({
  selector: 'app-${class.getName()?uncap_first}-edit',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './${class.getName()?uncap_first}-edit.component.html',
  styleUrl: './${class.getName()?uncap_first}-edit.component.scss',
})
export class ${class.getName()}EditComponent implements OnInit {
  ${class.getName()?uncap_first}Form!: FormGroup;
  isEditMode: boolean = false;
    <#list properties as property>
    <#if property.class.name == "myplugin.generator.fmmodel.FMReferenceProperty">
        ${property.name?uncap_first}: ${property.name}[] = [];
    </#if>
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
        this.fetchStudentData(studentId);
      }
    });
  }

  private fetch${class.getName()}Data(${class.getName()?uncap_first}Id: number): void {
    this.service.findById(${class.getName()?uncap_first}Id).then((${class.getName()?uncap_first}Data: any) => {
      this.grades = ${class.getName()?uncap_first}Data.grades;
      this.${class.getName()?uncap_first}Form.patchValue({
        <#list properties as property>
            <#if property.class.name != "myplugin.generator.fmmodel.FMReferenceProperty">
                this.fetch${class.getName()}Data.(${property.name});
            </#if>
        </#list>
      });
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
}
