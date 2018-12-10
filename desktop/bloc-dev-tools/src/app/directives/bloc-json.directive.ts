import { Directive, ElementRef, Input, OnInit } from '@angular/core';
import JSONFormatter from 'json-formatter-js';

@Directive({
  selector: '[blocJson]'
})
export class BlocJsonDirective implements OnInit {
  @Input() blocJson: any;

  constructor(private el: ElementRef) {}

  ngOnInit() {
    console.log(this.blocJson);
    const jsonFormatter = new JSONFormatter(this.blocJson, 1, {
      theme: 'dark'
    });
    (this.el.nativeElement as Element).appendChild(jsonFormatter.render());
  }
}
