import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute } from '@angular/router';
import { StudentService } from '../../shared/service/student/student.service';
import { Grade } from '../../shared/model/grade';

@Component({
  selector: 'app-student-view',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './student-view.component.html',
  styleUrl: './student-view.component.scss'
})
export class StudentViewComponent implements OnInit{
  isEditMode: boolean = false;
  name: string = "";
  age: string = "";
  grades: Grade[] = [];

  constructor(
    private route: ActivatedRoute,
    private service: StudentService
  ) {}

  ngOnInit(): void {
    this.checkEditMode();
  }

  private checkEditMode(): void {
    this.route.params.subscribe((params) => {
      if (params['id']) {
        const studentId = params['id'];
        this.isEditMode = true;
        this.fetchStudentData(studentId);
      }
    });
  }

  private fetchStudentData(studentId: number): void {
    this.service.findById(studentId).then((studentData: any) => {
      this.age = studentData.age;
      this.name = studentData.name;
      this.grades = studentData.grades;
      console.log(studentData);
    });
  }

}
