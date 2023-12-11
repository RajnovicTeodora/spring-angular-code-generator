import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ${class.getName()}sComponent } from './${class.getName()?uncap_first}s.component';

describe('${class.getName()}sComponent', () => {
  let component: ${class.getName()}sComponent;
  let fixture: ComponentFixture<${class.getName()}sComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [${class.getName()}sComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(${class.getName()}sComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
