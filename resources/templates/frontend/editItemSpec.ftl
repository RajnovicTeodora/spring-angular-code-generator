import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ${class.getName()}EditComponent } from './${class.getName()?uncap_first()}-edit.component';

describe('${class.getName()}EditComponent', () => {
  let component: ${class.getName()}EditComponent;
  let fixture: ComponentFixture<${class.getName()}EditComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [${class.getName()}EditComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(${class.getName()}EditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
