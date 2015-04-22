/*  $Id:$
 *  =================================================================
 */

    @class PicrossLevel;
    @class LibSliver;
    
    @interface PicrossGame : NSObject
    {
        UIImage*            tile; 
        PicrossLevel*       lvl;
        NSMutableArray*     map; 
        LibSliver*          sliver; 
        NSString*           caption;
        CGSize              tileSize; 

        NSMutableArray*     numbersCols;
        NSMutableArray*     numbersRows;

        int                 startTimestamp;
        int                 levelTime;
    
        int                 rows; 
        int                 cols; 

        int                 gamefieldWidth; 
        int                 gamefieldHeight; 
 
        int                 offX; 
        int                 offY; 
        
        int                 errorAnimation;
        int                 ticksTillGameOver;
        
        BOOL                gameWon;
        BOOL                gameLost;
        BOOL                iActionChisel;
        
        int                 colSelector;
        BOOL                selectorGetsDarker;
    }
    
    - (void) init : (int)aLevelTime; 

    - (void) run;
    
    - (void) handlePointer : (CGPoint)p;
        
    - (void) notifyError;
        
    - (void) paint : (CGRect) canvas;

//    - (void) drawSelector : (CGRect) canvas;

    - (void) drawNumbers : (CGRect) canvas;

    - (void) drawGamefieldGrid : (CGRect) canvas;

    - (void) drawGamefieldTiles : (CGRect) canvas;
    
    - (void) drawTime : (CGRect) canvas;

    - (void) drawInstructions : (CGRect) canvas;
    
    - (LibSliver*) getSliver;

    - (NSString*) getCaption;

    - (void) notifyError;
    
    - (void) notifyOpen : (int)tileX : (int)tileY;
    
    - (BOOL) allFieldsOpen;
    
    - (CGSize) getTileSize;
    
    - (void) substractPawsedTime : (long)pawsedTime;
    
    - (void) animateSelector;
    
    - (void) drawActionMenu : (CGRect)canvas;
    
    @end
