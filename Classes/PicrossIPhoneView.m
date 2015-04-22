/*  $Id:$
 *  =================================================================
 */

    #import "Picross.h"
    #import "PicrossIPhoneView.h"
    #import "LibDebug.h"
    #import "LibUtil.h"

    @implementation PicrossIPhoneView
    
    // Implement loadView to create a view hierarchy programmatically, without using a nib.
    - (void)loadView 
    {
        //this method is not passed!
    }

    - (void) drawRect : (CGRect)rect 
    {
        //propagate to main context
        [ singletonMainContext paint : rect ];
    
/*    
        if ( false )
        {
            CGContextRef context = UIGraphicsGetCurrentContext(); 
            
            CGContextSetLineWidth(context, 2.0); 

            UIColor *color= [UIColor blackColor];
            CGContextSetStrokeColorWithColor(context, color.CGColor); 
            CGContextClearRect(context,rect);

            
            UIColor *color2= [UIColor blueColor];
            CGContextSetStrokeColorWithColor(context, color2.CGColor); 
            
            CGContextMoveToPoint(context, 10.0,10.0 ); 
            CGContextAddLineToPoint(context, x,100.0); 
            CGContextAddLineToPoint(context, x + 100.0,0.0); 
            CGContextStrokePath(context);            
            
            x += 1.0;
            
            [ color release ];
        }
*/            
    }

    - (void) dealloc 
    {
        [ super dealloc ];
    }
    
    - (void) touchesBegan : (NSSet*) touches withEvent : (UIEvent*) event
    {
        [ LibDebug out : @"PicrossIPhoneView:touchesBegan --- x and y are:" ]; 
        
        CGPoint p = [ LibUtil getFirstTouchPoint : touches : self ];

        [ LibDebug out : [ LibUtil intToString : p.x ] ];  
        [ LibDebug out : [ LibUtil intToString : p.y ] ];  
        
        [ singletonMainContext handlePointer : p ];
    }
    
    - (void) touchesMoved : (NSSet*) touches withEvent : (UIEvent*) event
    {
        //[ LibDebug out : @"PicrossIPhoneView:touchesMoved" ]; 
    }
    
    - (void) touchesEnded : (NSSet*) touches withEvent : (UIEvent*) event
    {
        //[ LibDebug out : @"PicrossIPhoneView:touchesEnded" ]; 
    }
    
    - (void) touchesCancelled : (NSSet*) touches withEvent : (UIEvent*) event    
    {
        //[ LibDebug out : @"PicrossIPhoneView:touchesCencelled" ]; 
    }

    @end
