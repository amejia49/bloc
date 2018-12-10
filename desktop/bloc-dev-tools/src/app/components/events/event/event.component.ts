import { Component, Input } from '@angular/core';
import { Transition } from '../../../models';

@Component({
  selector: 'bloc-event',
  templateUrl: './event.component.html',
  styleUrls: ['./event.component.scss']
})
export class EventComponent {
  @Input()
  transition: Transition;
}
