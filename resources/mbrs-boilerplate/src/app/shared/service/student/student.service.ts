import { HttpClient, HttpResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Student } from '../../model/student';
import { Observable, firstValueFrom } from 'rxjs';

const students: Student[] = [
  { id: 1, name: 'John Doe', age: 12 },
  { id: 2, name: 'Jane Smith', age: 52 },
  { id: 3, name: 'Alice Johnson', age: 26 },
];

const getStudentsObservable = (): Observable<Student[]> => {
  return new Observable<Student[]>((observer) => {
    setTimeout(() => {
      observer.next(students);
      observer.complete();
    }, 1000);
  });
};

const getOneStudent = (): Observable<Student> => {
  return new Observable<Student>((observer) => {
    setTimeout(() => {
      observer.next(students[0]);
      observer.complete();
    }, 1000);
  });
};

@Injectable({
  providedIn: 'root',
})
export class StudentService {
  constructor(private httpClient: HttpClient) {}

  findAll(): Promise<Student[]> {
    return firstValueFrom(
      //this.httpClient.get<Student[]>(`http://localhost:4000/api/student`)
      getStudentsObservable()
    );
  }

  findById(id: number): Promise<Student> {
    return firstValueFrom(
      //this.httpClient.get<Student>(`http://localhost:4000/api/student/${id}`)
      getOneStudent()
    );
  }

  create(student: Student): Promise<HttpResponse<Student>> {
    return firstValueFrom(
      this.httpClient.post<Student>(
        `http://localhost:4000/api/student`,
        student,
        { observe: 'response' }
      )
    );
  }

  update(id: number, student: Student): Promise<HttpResponse<Student>> {
    return firstValueFrom(
      this.httpClient.put<Student>(
        `http://localhost:4000/api/student/${id}`,
        student,
        { observe: 'response' }
      )
    );
  }

  delete(id: number) {
    this.httpClient.delete(`http://localhost:4000/api/student/${id}`);
  }
}
