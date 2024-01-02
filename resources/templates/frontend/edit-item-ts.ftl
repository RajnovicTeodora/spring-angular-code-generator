<#assign hasIdProperty = false>
<#assign idName = "id">
<#list primitiveProperties as prim>
  <#if prim.isId>
    <#assign hasIdProperty = true>
    <#assign idName = prim.name>
  </#if>
</#list>
import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import {
  FormControl,
  FormBuilder,
  FormGroup,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
<#list referenceProperties as property>
import { ${property.type?cap_first}Service } from '../../shared/service/${property.type?cap_first}/${property.type?cap_first}.service';
  	</#list>
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
    <#if property.type == "int" || property.type == "long" || property.type == "Integer" || property.type == "float" || property.type == "Double" || property.type == "double" >
        ${property.name?uncap_first}: number = 0;
    <#elseif property.type == "String" || property.type == "char">
    	${property.name?uncap_first}: string = "";
    <#elseif property.type == "boolean">
    	${property.name?uncap_first}: boolean = false;
    <#elseif property.frontType == "string">
    	${property.name?uncap_first}: ${property.frontType} = "";
    <#else>
    	${property.name?uncap_first}: ${property.frontType} = null;
    </#if>
  </#list>
   <#list referenceProperties as property>
		<#if property.upper == 1>
        ${property.name?uncap_first}: ${property.type?cap_first} | null = null;
        all${property.name?cap_first}s : any = [];
        ${property.name?uncap_first}Control = new FormControl<any | null>(null, Validators.required);
        <#else>
        ${property.name?uncap_first}: ${property.type?cap_first}[] = [];
        all${property.name?cap_first}: ${property.type?cap_first}[] = [];
        </#if>
  </#list>
  <#if !hasIdProperty>
  	${idName}: number=0;
  </#if>

  constructor(
    private fb: FormBuilder,
    private route: ActivatedRoute,
    private service: ${class.getName()}Service,
    <#list referenceProperties as property>
	private ${property.type?uncap_first}Service: ${property.type?cap_first}Service,
  	</#list>
  ) {}

  ngOnInit(): void {
    this.initializeForm();
    this.checkEditMode();
  }

  private initializeForm(): void {
  
   if (!this.isEditMode){
    this.${class.getName()?uncap_first}Form = this.fb.group({
    <#list properties as property>
        <#if property.class.name != "myplugin.generator.fmmodel.FMReferenceProperty">
            ${property.name}: ['', Validators.required],
        </#if>
    </#list>
    });
     <#list referenceProperties as prop>
  	<#if prop.upper == -1>
    this.${prop.type?uncap_first}Service.findAll().then((${prop.getName()})=>{ this. all${prop.name?cap_first}=${prop.getName()};
    })
    <#else>
     this.${prop.type?uncap_first}Service.findAll().then((temp)=>{this.all${prop.type?cap_first}s=temp;})
    </#if>
    </#list>
    }else{
    this.${class.getName()?uncap_first}Form = this.fb.group({
    <#list primitiveProperties as property>
            ${property.name}: [this.${property.name}, Validators.required],
    </#list>
    });
    }
  }
  
  <#list referenceProperties as prop>
  <#if prop.upper == -1>
   public add${prop.type?cap_first}(id: any):void{
    const g: ${prop.type?cap_first} | undefined = this.all${prop.name?cap_first}.find(x => x.id === id);
    if (g) {
      this.${prop.name}.push(g);
    } else {
      console.error(`No Grade found with id`);
    }
  
  }
  public remove${prop.type?cap_first}(id: any): void {
    this.${prop.name} = this.${prop.name}.filter(x => x.id !== id);
  }
 public check${prop.type?cap_first}(id: any): boolean{
    return this.${prop.name}.find(x => x.id === id)? true: false;
  }
</#if>
  </#list>
  
  

  private checkEditMode(): void {
    this.route.params.subscribe((params) => {
      if (params['id']) {
        const ${class.getName()?uncap_first}Id = params['id'];
        this.isEditMode = true;
        this.${idName} = ${class.getName()?uncap_first}Id;
        this.fetch${class.getName()}Data(${class.getName()?uncap_first}Id);
      }
        <#list referenceProperties as prop>
  	<#if prop.upper == -1>
  	this.service.find${prop.name?cap_first}By${class.getName()?cap_first}${idName?cap_first}(this.${idName}).then((${prop.name}: any)=>{
      this.${prop.name} = ${prop.name};
   
    this.${prop.type?uncap_first}Service.findAll().then((${prop.name})=>{ this.all${prop.name?cap_first}=${prop.name?uncap_first};
    })
     })
    </#if>
  </#list>
    });
  }

  private fetch${class.getName()}Data(${class.getName()?uncap_first}Id: number): void {
    this.service.findById(${class.getName()?uncap_first}Id).then((${class.getName()?uncap_first}Data: any) => {
    
    <#list referenceProperties as property>
    if(${class.getName()?uncap_first}Data.${property.name?uncap_first} != undefined  ){
        this.${property.name?uncap_first}=  ${class.getName()?uncap_first}Data.${property.name?uncap_first};}
  </#list>
      this.${class.getName()?uncap_first}Form.patchValue({
        <#list primitiveProperties as property>
              ${property.name?uncap_first}: ${class.getName()?uncap_first}Data.${property.name?uncap_first},
        </#list>
      });
    });
  }

  onSubmit(): void {
  	<#list referenceProperties as prop>
  		<#if prop.upper != -1>
    const temp${prop.type?cap_first} =this.${prop.type?uncap_first}Control.value?  this.${prop.type?uncap_first}Control.value: null;
    const matchingS${prop.type?cap_first}s = this.all${prop.type?cap_first}s.filter((s: any) => s.id+"" === temp${prop.type?cap_first});

    if (matchingS${prop.type?cap_first}s.length > 0) {
      this.${prop.name} = matchingS${prop.type?cap_first}s[0];
    }
    	</#if>
    </#list>
  
  
  
    if (this.${class.getName()?uncap_first}Form.valid) {
      const formData = this.${class.getName()?uncap_first}Form.value;
       const ${class.getName()?uncap_first} = new ${class.getName()?cap_first}(
       <#list primitiveProperties as prop> formData["${prop.name}"],</#list><#list referenceProperties as prop>this.${prop.name},</#list> <#if !hasIdProperty>this.id</#if>)
      
      if (this.isEditMode) {
      	const resp = this.service.update(this.${idName}, ${class.getName()?uncap_first});
      } else {
       const resp =   this.service.create(${class.getName()?uncap_first});
        // this.${class.getName()?uncap_first}Service.create(formData).subscribe(...);
      }
    }
  }
  <#list referenceProperties as property>
   public getObjectProperties${property.name?cap_first}(${property.name?uncap_first}: ${property.type?cap_first} | null): any {
    return Object.keys(${property.name?uncap_first}? ${property.name?uncap_first}:{});
  }
  public getValue${property.name?cap_first}(${property.type?uncap_first}: ${property.type?cap_first}, property: string): any{
    return ${property.type?uncap_first}[property];
  }
  </#list>
  
  
}
