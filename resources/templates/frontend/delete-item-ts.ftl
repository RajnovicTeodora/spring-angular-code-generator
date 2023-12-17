import { Component, OnInit  } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';
import { ${class.getName()} } from '../../shared/model/${class.getName()}';

@Component({
  selector: 'app-${class.getName()?uncap_first}-delete',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './${class.getName()?uncap_first}-delete.component.html',
  styleUrl: './${class.getName()?uncap_first}-delete.component.scss'
})
export class ${class.getName()}DeleteComponent implements OnInit{
  ${class.getName()?uncap_first}?: ${class.getName()};

  ngOnInit(): void {
  }
  constructor(
    //protected ${class.getName()?uncap_first}Service: ${class.getName()}Service, 
    protected activeModal: NgbActiveModal) {}

  cancel(): void {
    this.activeModal.dismiss();
  }

  confirmDelete(id: number): void {
    // this.${class.getName()?uncap_first}Service.delete(id).subscribe(() => {
    //   this.activeModal.close('deleted');
    // });
  }

}
