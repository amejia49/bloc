import { Component, Input } from '@angular/core';
import { Transition } from '../../models';

@Component({
  selector: 'bloc-event-details',
  templateUrl: './event-details.component.html',
  styleUrls: ['./event-details.component.scss']
})
export class EventDetailsComponent {
  @Input()
  transition: Transition;
}
