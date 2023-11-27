import { Grade } from "./grade";

export class Student {
  id: number;
  name: string;
  age: number;
  grades: Grade[];

  constructor(id: number, name: string, age: number, grades:  Grade[]) {
    this.id = id;
    this.name = name;
    this.age = age;
    this.grades = grades;
  }
}
