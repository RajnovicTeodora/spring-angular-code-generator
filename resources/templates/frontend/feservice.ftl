<#assign hasIdProperty = false>
<#assign idName = "">
<#assign idType = "">
<#list class.primitiveProperties as prim>
  <#if prim.isId>
    <#assign hasIdProperty = true>
    <#assign idName = prim.name>
    <#if prim.type == 'string'>
      <#assign idType = 'string'>
    <#else>
      <#assign idType = 'number'>
    </#if>
  </#if>
</#list>
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ${class.name} } from '../../model/${class.name}';
import { firstValueFrom } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class ${class.name}Service {
  constructor(private httpClient: HttpClient) {}

  findAll(): Promise<${class.name}[]> {
    return firstValueFrom(
      this.httpClient.get<${class.name}[]>(`http://localhost:4000/api/${class.name?uncap_first}`)
    );
  }

  findById(<#if hasIdProperty>${idName?uncap_first}: ${idType}<#else>id: number</#if>): Promise<${class.name}> {
    return firstValueFrom(
      this.httpClient.get<${class.name}>(`http://localhost:4000/api/${class.name?uncap_first}/${'${'}<#if hasIdProperty>${idName?uncap_first}<#else>id</#if>}`)
    );
  }

  create(${class.name?uncap_first}: ${class.name}): Promise<HttpResponse<${class.name}>> {
    return firstValueFrom(
      this.httpClient.post<${class.name}>(
        `http://localhost:4000/api/${class.name?uncap_first}`,
        ${class.name?uncap_first},
        { observe: 'response' }
      )
    );
  }

  update(<#if hasIdProperty>${idName?uncap_first}: ${idType}<#else>id: number</#if>, ${class.name?uncap_first}: ${class.name}): Promise<HttpResponse<${class.name}>> {
    return firstValueFrom(
      this.httpClient.put<${class.name}>(
        `http://localhost:4000/api/${class.name?uncap_first}/${'${'}<#if hasIdProperty>${idName?uncap_first}<#else>id</#if>}`,
        ${class.name?uncap_first},
        { observe: 'response' }
      )
    );
  }

  delete(<#if hasIdProperty>${idName?uncap_first}: ${idType}<#else>id: number</#if>) {
    this.httpClient.delete(`http://localhost:4000/api/${class.name?uncap_first}/${'${'}<#if hasIdProperty>${idName?uncap_first}<#else>id</#if>}`);
  }
}
