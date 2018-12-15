import { Component, Input, Output, EventEmitter } from '@angular/core';
import { Transition } from '../../../models';

@Component({
  selector: 'bloc-event',
  templateUrl: './event.component.html',
  styleUrls: ['./event.component.scss']
})
export class EventComponent {
  @Input()
  transition: Transition;

  @Input()
  active: boolean;

  @Output()
  jump = new EventEmitter<void>();

  onJump() {
    this.jump.emit();
  }
}
