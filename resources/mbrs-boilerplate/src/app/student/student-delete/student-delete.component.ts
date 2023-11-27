import { Component, OnInit  } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';
import { Student } from '../../shared/model/student';

@Component({
  selector: 'app-student-delete',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './student-delete.component.html',
  styleUrl: './student-delete.component.scss'
})
export class StudentDeleteComponent implements OnInit{
  student?: Student;

  ngOnInit(): void {
  }
  constructor(
    //protected studentService: StudentService, 
    protected activeModal: NgbActiveModal) {}

  cancel(): void {
    this.activeModal.dismiss();
  }

  confirmDelete(id: number): void {
    // this.studentService.delete(id).subscribe(() => {
    //   this.activeModal.close('deleted');
    // });
  }

}
