/*  $Id:$
 *  =================================================================
 */

    #import "Picross.h"
    #import "PicrossIPhoneViewController.h"
    #import "LibDebug.h"
    #import "LibThread.h"
    
    @implementation LibThread

    //TODO constructor with callback and delay!

    - (void) start
    {
        [ LibDebug out : @"Thread START" ];
        [ NSTimer scheduledTimerWithTimeInterval : 0.01 target : self selector : @selector( run ) userInfo : nil repeats : YES ];
      
        //2nd solution
      //[ NSThread detachNewThreadSelector : @selector (run) toTarget : self withObject : nil ];
    }

    - (void) run
    {
        //no keys on iphone!
        //[ singletonMainContext handleKeys ];

        //call onRun
        [ singletonMainContext run ];
    
        //repaint
        [ singletonMainView setNeedsDisplay ];

        //show system dialogs
        [ singletonMainContext showSystemDialogs ];
    }

    @end
