import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import {
  FormBuilder,
  FormGroup,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { StudentService } from '../../shared/service/student/student.service';
import { Grade } from '../../shared/model/grade';

@Component({
  selector: 'app-student-edit',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './student-edit.component.html',
  styleUrl: './student-edit.component.scss',
})
export class StudentEditComponent implements OnInit {
  studentForm!: FormGroup;
  isEditMode: boolean = false;
  grades: Grade[] = [];

  constructor(
    private fb: FormBuilder,
    private route: ActivatedRoute,
    private service: StudentService
  ) {}

  ngOnInit(): void {
    this.initializeForm();
    this.checkEditMode();
  }

  private initializeForm(): void {
    this.studentForm = this.fb.group({
      name: ['', Validators.required],
      age: ['', Validators.required],
      // Add more form fields as needed
    });
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
      this.grades = studentData.grades;
      this.studentForm.patchValue({
        name: studentData.name,
        age: studentData.age,
        // Patch more form fields if needed
      });
    });
  }

  onSubmit(): void {
    if (this.studentForm.valid) {
      const formData = this.studentForm.value;
      if (this.isEditMode) {
        // Handle update logic using StudentService
        // Update student data with formData
        // this.studentService.updateStudent(formData).subscribe(...);
        console.log('Updating student:', formData);
      } else {
        // Handle creation logic using StudentService
        // Create new student with formData
        // this.studentService.createStudent(formData).subscribe(...);
        console.log('Creating student:', formData);
      }
    }
  }
}
