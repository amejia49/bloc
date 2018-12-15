import { Injectable } from '@angular/core';
import { ReplaySubject, Observable } from 'rxjs';
import { Transition } from '../models';
import { IpcRenderer } from 'electron';

@Injectable()
export class TransitionService {
  private transitionsSubject: ReplaySubject<Transition>;
  private ipcRenderer: IpcRenderer;
  transitions: Observable<Transition>;

  constructor() {
    this.transitionsSubject = new ReplaySubject<Transition>();
    this.transitions = this.transitionsSubject.asObservable();
    if (this.isElectron()) {
      const { ipcRenderer } = require('electron');
      this.ipcRenderer = ipcRenderer;
      this.ipcRenderer.on('transition', (event: any, args: string) => {
          const transition: Transition = JSON.parse(args);
          this.transitionsSubject.next(transition);
        });
    }
    // this.transitionsSubject.next({
    //   currentState: 0,
    //   event: {
    //     type: 'Increment'
    //   },
    //   nextState: 1,
    //   timestamp: 0
    // });
    // this.transitionsSubject.next({
    //   currentState: 1,
    //   event: {
    //     type: 'Increment'
    //   },
    //   nextState: 2,
    //   timestamp: 0
    // });
    // this.transitionsSubject.next({
    //   currentState: 2,
    //   event: {
    //     type: 'Increment'
    //   },
    //   nextState: 3,
    //   timestamp: 0
    // });
    // this.transitionsSubject.next({
    //   currentState: 3,
    //   event: {
    //     type: 'Increment'
    //   },
    //   nextState: 4,
    //   timestamp: 0
    // });
    // this.transitionsSubject.next({
    //   currentState: 4,
    //   event: {
    //     type: 'Increment'
    //   },
    //   nextState: 5,
    //   timestamp: 0
    // });
  }

  dispatch(transition: Transition) {
    console.log('dispatching', transition);
    this.ipcRenderer.send('dispatch', transition);
  }

  private isElectron() {
    return window && window.process && window.process.type;
  }
}
