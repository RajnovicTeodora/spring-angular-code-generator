import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { StudentService } from '../../shared/service/student/student.service';
import { Student } from '../../shared/model/student';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faAdd, faInfo } from '@fortawesome/free-solid-svg-icons';
import { Router } from '@angular/router';

@Component({
  selector: 'app-students',
  standalone: true,
  imports: [CommonModule, FontAwesomeModule],
  templateUrl: './students.component.html',
  styleUrl: './students.component.scss',
})
export class StudentsComponent implements OnInit {
  students: Student[] = [];
  faInfo = faInfo;
  faAdd = faAdd;

  constructor(private service: StudentService, private router: Router) {}

  ngOnInit(): void {
    this.initializeData();
  }

  async initializeData() {
    this.students = await this.service.findAll();
  }

  open(id: number) {
    this.router.navigate(['students', id]);
  }

  create() {
    this.router.navigate(['students', 'new']);
  }
}
