/*  $Id:$
 *  =================================================================
 */

    #import "LibUtil.h"

    @implementation LibUtil

    + (NSString*) intToString : (int)aInt
    {
        NSString* ret = [ NSString stringWithFormat : @"%d", aInt ];            
        return ret;
    }
    
    + (NSString*) longToString : (long long)aLong
    {
        NSString* ret = [ NSString stringWithFormat : @"%qi", aLong ];            
        return ret;
    }

    + (UIColor*) intToColor : (int)aInt
    {
        float a = ( ( aInt >> 24 ) & 0xff ) / 256.0f;
        float r = ( ( aInt >> 16 ) & 0xff ) / 256.0f;
        float g = ( ( aInt >> 8  ) & 0xff ) / 256.0f;
        float b = ( ( aInt >> 0  ) & 0xff ) / 256.0f;

        UIColor* col = [ UIColor colorWithRed: r green : g blue : b alpha : a ];

        return col;
    }
    
    + (CGPoint) getFirstTouchPoint : (NSSet*)touches : (UIView*)view
    {
        for ( UITouch* touch in touches )
        {
            CGPoint p = [ touch locationInView : view ];
            return p;
        }
        return CGPointMake( 0, 0 );
    }

    @end
