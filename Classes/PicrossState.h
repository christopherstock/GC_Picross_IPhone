/*  $Id:$
 *  =================================================================
 */
    
    enum States
    {
        EStateMainMenu      = 0,
        EStateIngame        = 1,
    };    

    @class PicrossLevel;
    @class PicrossMainMenu;
    @class PicrossGame;

    @interface PicrossState : NSObject 
    {
        PicrossMainMenu*    mainMenu            ;
        PicrossLevel*       level               ;
        PicrossGame*        game                ;

        int                 currentState        ;
    }
    
    - (void) startEasyGame;

    - (void) startMediumGame;

    - (void) startHardGame;

    - (void) init : (PicrossIPhoneView*) canvas;

    - (void) run;
    
    - (void) handlePointer : (CGPoint)p;
    
    - (void) paint : (CGRect) canvas;
    
    - (PicrossGame*) getGame;

    - (PicrossLevel*) getLevel;
    
    - (void) returnToMainMenu;
    
    @end
