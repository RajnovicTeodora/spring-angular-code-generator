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

  findById(id: number): Promise<${class.name}> {
    return firstValueFrom(
      this.httpClient.get<${class.name}>(`http://localhost:4000/api/${class.name?uncap_first}/${'${'}id}`)
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

  update(id: number, ${class.name?uncap_first}: ${class.name}): Promise<HttpResponse<${class.name}>> {
    return firstValueFrom(
      this.httpClient.put<${class.name}>(
        `http://localhost:4000/api/${class.name?uncap_first}/${'${'}id}`,
        ${class.name?uncap_first},
        { observe: 'response' }
      )
    );
  }

  delete(id: number) {
    this.httpClient.delete(`http://localhost:4000/api/${class.name?uncap_first}/${'${'}id}`);
  }
}
