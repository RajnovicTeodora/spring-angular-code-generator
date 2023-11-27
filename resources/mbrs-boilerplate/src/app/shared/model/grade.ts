export class Grade {
    id: number;
    subject: string;
    gradeNum: number;
  
    constructor(id: number, subject: string, gradeNum: number) {
      this.id = id;
      this.subject = subject;
      this.gradeNum = gradeNum;
      
    }
  }