/*  $Id:$
 *  =================================================================
 */

    enum MainMenuItems
    {
        EMainMenuItemStartEasyGame      = 0,
        EMainMenuItemStartMediumGame    = 1,
        EMainMenuItemStartHardGame      = 2,
        EMainMenuItemIndices            = 3,
    };

    @class PicrossIPhoneView;

    @interface PicrossMainMenu : NSObject 
    {
        int     currentIndex;
           
        float   alphaLogo;
                 
        float   bgX;        
        float   bgY;        
        int     bgDirection;        
    }

    - (void) handlePointer : (CGPoint)p;

    - (void) run;

    - (void) paint : (CGRect)canvas;

    - (void) init : (PicrossIPhoneView*) canvas;

    - (void) changeBgDirection;

    @end
