import { Component, OnInit, OnDestroy } from '@angular/core';
import { Subscription } from 'rxjs';

import { TransitionService } from '../../providers';
import { Transition } from '../../models';
import { formatTimestamp } from '../../utils';

@Component({
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit, OnDestroy {
  private transitionSubscription: Subscription;
  private currentTimestamp: number;
  transitions: Transition[] = [];
  selectedTransition: Transition;

  constructor(private transitionService: TransitionService) {}

  ngOnInit() {
    this.transitionSubscription = this.transitionService.transitions.subscribe(
      transition => {
        if (typeof this.currentTimestamp === 'undefined') {
          this.currentTimestamp = transition.timestamp;
          transition.timestamp = '+00:00.00';
        } else {
          transition.timestamp = formatTimestamp(
            transition.timestamp - this.currentTimestamp
          );
        }
        this.transitions.push(transition);
        if (typeof this.selectedTransition === 'undefined') {
          this.selectedTransition = this.transitions[0];
        }
      }
    );
  }

  ngOnDestroy() {
    this.transitionSubscription.unsubscribe();
  }
}
