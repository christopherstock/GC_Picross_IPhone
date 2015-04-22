/*  $Id:$
 *  =================================================================
 */
     
    @class LibThread;
    @class LibKeySystem;
    @class PicrossResources;
    @class PicrossState;
    @class PicrossIPhoneView;
         
    @interface Picross : NSObject 
    {
        float               canvas_width;
        float               canvas_height;
            
//        NSSound*            soundBg;
        BOOL                soundBgPlays;
            
        BOOL                enableSounds;
            
        LibThread*          thread;
        PicrossResources*   resources;
        PicrossState*       state;
        LibKeySystem*       keys;

        BOOL                showDialogWon;
        BOOL                showDialogLost;
        BOOL                showDialogPaws;
    }
       
    extern  Picross*    singletonMainContext;

    - (void) init : (PicrossIPhoneView*) canvas ;

    - (void) paint : (CGRect) canvas;
        
    - (void) handlePointer : (CGPoint)p;
    
    - (void) run;
    
    - (PicrossState*) getState;

    - (PicrossResources*) getResources;
    
    - (int) getCanvasWidth;

    - (int) getCanvasHeight;
    
    - (LibKeySystem*) getKeys;
    
    - (void) pawsOrResumeBgSound;
    
    - (void) showSystemDialogs;
    
    - (void) doShowDialogWon;

    - (void) doShowDialogLost;

    - (void) doShowDialogPaws;
    
    - (BOOL) isPawsed;
    
    @end
