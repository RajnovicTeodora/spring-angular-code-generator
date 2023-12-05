import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ${class.name}ViewComponent } from './${class.name?uncap_first}-view.component';

describe('${class.name}ViewComponent', () => {
  let component: ${class.name}ViewComponent;
  let fixture: ComponentFixture<${class.name}ViewComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [${class.name}ViewComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(${class.name}ViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
