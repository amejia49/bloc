import {
  Directive,
  ElementRef,
  Input,
  OnInit,
  OnChanges,
  SimpleChanges
} from '@angular/core';
import JSONFormatter from 'json-formatter-js';

@Directive({
  selector: '[blocJson]'
})
export class BlocJsonDirective implements OnInit, OnChanges {
  @Input() blocJson: any;

  constructor(private el: ElementRef) {}

  ngOnInit() {
    this.renderJson();
  }

  ngOnChanges(changes: SimpleChanges) {
    this.renderJson();
  }

  private renderJson() {
    (this.el.nativeElement as Element).innerHTML = '';
    const jsonFormatter = new JSONFormatter(this.blocJson, 1, {
      theme: 'dark'
    });
    (this.el.nativeElement as Element).appendChild(jsonFormatter.render());
  }
}
