import { Component, Input } from '@angular/core';
import { Transition } from '../../models';

@Component({
  selector: 'bloc-events',
  templateUrl: './events.component.html'
})
export class EventsComponent {
  @Input()
  transitions: Transition[];
}
