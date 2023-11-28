import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ${class.getName()}DeleteComponent } from './${class.getName()?uncap_first}-delete.component';

describe('${class.getName()}DeleteComponent', () => {
  let component: ${class.getName()}DeleteComponent;
  let fixture: ComponentFixture<${class.getName()}DeleteComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [${class.getName()}DeleteComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(${class.getName()}DeleteComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
