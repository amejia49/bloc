import { Component, Input, Output, EventEmitter } from '@angular/core';
import { Transition } from '../../models';

@Component({
  selector: 'bloc-events',
  templateUrl: './events.component.html',
  styleUrls: ['./events.component.scss']
})
export class EventsComponent {
  @Input()
  transitions: Transition[];

  @Input()
  activeTransitionIndex: number;

  @Output()
  selected = new EventEmitter<number>();

  @Output()
  jump = new EventEmitter<number>();

  @Output()
  clearAll = new EventEmitter<void>();

  onSelected(index: number) {
    this.selected.emit(index);
  }

  onJump(index: number) {
    this.jump.emit(index);
  }

  onClearAll() {
    this.clearAll.emit();
  }
}
