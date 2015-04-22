/*  $Id:$
 *  =================================================================
 */

    #import "PicrossMainMenu.h"
    #import "Picross.h"
    #import "PicrossResources.h" 
    #import "PicrossSettings.h" 
    #import "PicrossState.h" 
    #import "LibDebug.h" 
    #import "LibDrawing.h" 
    #import "LibKey.h" 
    #import "LibKeySystem.h" 
    #import "LibMath.h" 
    #import "LibUtil.h" 

    @implementation PicrossMainMenu

    int     currentIndex        = EMainMenuItemStartEasyGame;
    
    float   alphaLogo           = 0.0f;
    float   bgX                 = 0;
    float   bgY                 = 0;
    int     bgDirection         = 0;
    
    - (void) init : (PicrossIPhoneView*) canvas 
    {
        //center bg image 
        bgX = - ( [ [ [ singletonMainContext getResources ] getImage : EImgMenuBg ] size ].width  - [ canvas size ].width  ) / 2;
        bgY = - ( [ [ [ singletonMainContext getResources ] getImage : EImgMenuBg ] size ].height - [ canvas size ].height ) / 2;
        
        //let random select start direction
        [ self changeBgDirection ];
    }
    
    - (void) changeBgDirection
    {
        bgDirection = [ LibMath getRandomInt : EDirectionNorth : EDirectionNorthWest ];
        
        //NSLog( @"random direction >>> %d", bgDirection );
    }

    - (void) handlePointer : (CGPoint)p
    {
/*    
        [ LibDrawing drawString : @"START EASY GAME",   70, 230, EMenuItemUnselectedFill, EMenuItemUnselectedBorder, 23 ];
        [ LibDrawing drawString : @"START MEDIUM GAME", 45, 270, EMenuItemUnselectedFill, EMenuItemUnselectedBorder, 23 ];
        [ LibDrawing drawString : @"START HARD GAME",   65, 310, EMenuItemUnselectedFill, EMenuItemUnselectedBorder, 23 ];
*/    
        //check if main menu items are clicked
        if ( p.y >= 230 && p.y < 263 )
        {
            [ LibDebug out : @"Easy game clicked!" ];
            [ [ singletonMainContext getState ] startEasyGame ]; 
        }
        else if ( p.y >= 270 && p.y < 303 )
        {
            [ LibDebug out : @"MEDIUM game clicked!" ]; 
            [ [ singletonMainContext getState ] startMediumGame ]; 
        }
        else if ( p.y >= 310 && p.y < 333 )
        {
            [ LibDebug out : @"Hard  game clicked!" ]; 
            [ [ singletonMainContext getState ] startHardGame ]; 
        }
    }

    - (void) run
    {
        //lower all key blockers
        [ [ singletonMainContext getKeys ] lowerAllKeyBlockers ];        

        //fade in logo
        alphaLogo += 0.003f;
        if ( alphaLogo > 1.0f ) alphaLogo = 1.0f;         
        
        //animate bg image
        {
            //move bg UP
            switch ( bgDirection )
            {
                case EDirectionNorth:
                case EDirectionNorthEast:
                case EDirectionNorthWest:
                {
                    if ( bgY < 0 ) 
                    {
                        ++bgY;
                    }
                    else 
                    {
                        [ self changeBgDirection ];
                    }
                    break;
                }
            }

            //move bg DOWN
            switch ( bgDirection )
            {
                case EDirectionSouth:
                case EDirectionSouthEast:
                case EDirectionSouthWest:
                {
                    if ( bgY > - ( [ [ [ singletonMainContext getResources ] getImage : EImgMenuBg ] size ].height - [ singletonMainContext getCanvasHeight ] ) ) 
                    {
                        --bgY;      
                    }
                    else 
                    {
                        [ self changeBgDirection ];
                    }
                    break;
                }
            }
            
            //move bg LEFT
            switch ( bgDirection )
            {
                case EDirectionNorthWest:
                case EDirectionWest:
                case EDirectionSouthWest:
                {
                    if ( bgX > - ( [ [ [ singletonMainContext getResources ] getImage : EImgMenuBg ] size ].width - [ singletonMainContext getCanvasWidth ] ) ) 
                    {
                        --bgX;
                    }
                    else 
                    {
                        [ self changeBgDirection ];
                    }
                    break;
                }
            }        
            
            //move bg RIGHT
            switch ( bgDirection )
            {
                case EDirectionNorthEast:
                case EDirectionEast:
                case EDirectionSouthEast:
                {
                    if ( bgX < 0 ) 
                    {
                        ++bgX;
                    }
                    else 
                    {
                        [ self changeBgDirection ];
                    }
                    break;
                }
            } 
        }       
    }
    
    - (void) paint : (CGRect) canvas
    {
        //fill screen white
        [ LibDrawing fillRect : EColorWhite : 0 : 0 : canvas.size.width : canvas.size.height ];

        //draw translucent img
        [ LibDrawing drawImage  : [ [ singletonMainContext getResources ] getImage : EImgMenuBg ] : bgX : bgY : EAnchorLeftBottom : EAlphaBg ];

        //draw border
        [ LibDrawing fillRect   : EColorWhite : 0                                       : 0                                       : canvas.size.width  : EOffsetBorderFrame ];
        [ LibDrawing fillRect   : EColorWhite : 0                                       : canvas.size.height - EOffsetBorderFrame : canvas.size.width  : EOffsetBorderFrame ];
        [ LibDrawing fillRect   : EColorWhite : 0                                       : 0                                       : EOffsetBorderFrame : canvas.size.height ];
        [ LibDrawing fillRect   : EColorWhite : canvas.size.width - EOffsetBorderFrame  : 0                                       : EOffsetBorderFrame : canvas.size.height ];

        //draw logo
        [ LibDrawing drawImage  : [ [ singletonMainContext getResources ] getImage : EImgLogoBig ] : canvas.size.width / 2 : canvas.size.height * 1 / 4 : EAnchorCenterMiddle : alphaLogo ];
        
        //draw items
        [ LibDrawing drawString : @"START EASY GAME",   70, 230, EMenuItemUnselectedFill, EMenuItemUnselectedBorder, 23 ];
        [ LibDrawing drawString : @"START MEDIUM GAME", 45, 270, EMenuItemUnselectedFill, EMenuItemUnselectedBorder, 23 ];
        [ LibDrawing drawString : @"START HARD GAME",   65, 310, EMenuItemUnselectedFill, EMenuItemUnselectedBorder, 23 ];
/*            
        //draw instructions ( key control only )
        [ LibDrawing drawString : @"\u2193 \u2191", 80,         350, EColorSynapsyBlue,    0x00ffffff, 15 ];
        [ LibDrawing drawString : @"ENTER",         80,         370, EColorSynapsyBlue,    0x00ffffff, 15 ];
        [ LibDrawing drawString : @"Select",        150,         350, EColorBlack,          EColorWhite, 15 ];
        [ LibDrawing drawString : @"Start game",    150,         370, EColorBlack,          EColorWhite, 15 ];
        
        //draw line
        //[ LibDrawing drawLine : 0xffff0000 : 0 : 0 : canvas.size.width : canvas.size.height ];
*/
    }

    @end
