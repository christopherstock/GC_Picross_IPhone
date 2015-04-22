/*  $Id:$
 *  =================================================================
 */
     
    #import "LibDrawing.h"
    #import "LibUtil.h"

    @implementation LibDrawing

    + (void) drawString : (NSString*)str, int x, int y, int colFill, int colStroke, int fontSize
    {
        CGPoint pointShadow  = CGPointMake( x + 1, y - 1 );
        CGPoint pointFg      = CGPointMake( x,     y     );
        UIFont* font         = [ UIFont fontWithName : @"Futura-MediumItalic" size : fontSize ];
        
        CGContextRef context = UIGraphicsGetCurrentContext();

        NSMutableArray* f4s = [ LibDrawing to4f : colStroke ];
        NSMutableArray* f4f = [ LibDrawing to4f : colFill   ];

        //draw shadow  //TODO function for color assignment ?
        CGContextSetRGBFillColor( context, [ [ f4s objectAtIndex : 0 ] floatValue ], [ [ f4s objectAtIndex : 1 ] floatValue ], [ [ f4s objectAtIndex : 2 ] floatValue ], 1.0f ); // [ [ f4s objectAtIndex : 3 ] floatValue ] );
        [ str drawAtPoint : pointShadow withFont : font ];

        //draw fg
        CGContextSetRGBFillColor( context, [ [ f4f objectAtIndex : 0 ] floatValue ], [ [ f4f objectAtIndex : 1 ] floatValue ], [ [ f4f objectAtIndex : 2 ] floatValue ], 1.0f ); //[ [ f4f objectAtIndex : 3 ] floatValue ] );
        [ str drawAtPoint : pointFg withFont : font ];    
    }

    + (NSMutableArray*) to4f : (int)col
    {
        NSMutableArray* ret = [ [ NSMutableArray alloc] initWithCapacity : 4 ];

        [ ret addObject : [ NSNumber numberWithFloat : ( (float)( ( col >> 16 ) & 0xff ) / 0xff ) ] ];
        [ ret addObject : [ NSNumber numberWithFloat : ( (float)( ( col >> 8  ) & 0xff ) / 0xff ) ] ];
        [ ret addObject : [ NSNumber numberWithFloat : ( (float)( ( col >> 0  ) & 0xff ) / 0xff ) ] ];
        [ ret addObject : [ NSNumber numberWithFloat : ( (float)( ( col >> 24 ) & 0xff ) / 0xff ) ] ];
    
        return ret;
    }

    + (void) drawImage : (UIImage*)img : (float)x : (float)y : (int)ank : (float)alpha
    {
        switch ( ank )
        {
            case EAnchorLeftTop:        x -= 0;                         y -= [ img size ].height;       break;
            case EAnchorLeftMiddle:     x -= 0;                         y -= [ img size ].height / 2;   break;
            case EAnchorLeftBottom:     x -= 0;                         y -= 0;                         break;
        
            case EAnchorCenterTop:      x -= [ img size ].width / 2;    y -= [ img size ].height;       break;
            case EAnchorCenterMiddle:   x -= [ img size ].width / 2;    y -= [ img size ].height / 2;   break;
            case EAnchorCenterBottom:   x -= [ img size ].width / 2;    y -= 0;                         break;

            case EAnchorRightTop:       x -= [ img size ].width;        y -= [ img size ].height;       break;
            case EAnchorRightMiddle:    x -= [ img size ].width;        y -= [ img size ].height / 2;   break;
            case EAnchorRightBottom:    x -= [ img size ].width;        y -= 0;                         break;
        }
    
        //load and draw img
        CGPoint point1 = CGPointMake( x, y );
//        CGCompositingOperation op = NSCompositeSourceOver;
        
        //draw the img
//        [ img drawAtPoint: point1 fromRect: CGRectZero operation: op fraction : alpha ];

        [ img drawAtPoint: point1 ]; // fromRect: CGRectZero fraction : alpha ];

    }
    
    + (void) drawLine : (int)col : (int)x1 : (int)y1 : (int)x2 : (int)y2
    {
        //set stroke color
        [ [ LibUtil intToColor : col ] setStroke ];
        
        //create drawing path
        UIBezierPath* drawingPath = [ UIBezierPath bezierPath ];

        [ drawingPath moveToPoint : CGPointMake( x1, y1 ) ];
        [ drawingPath addLineToPoint : CGPointMake( x2, y2 ) ];
    
        //stroke path
        [ drawingPath stroke ];
    }

    + (void) fillRect : (int)col : (int)x : (int)y : (int)width : (int)height
    {
        //set fill color
        [ [ LibUtil intToColor : col ] setFill ];

        //specify rect
        CGRect  rect = CGRectMake( x, y, width, height );
        
        //create drawing path from rect
        UIBezierPath* drawingPath = [ UIBezierPath bezierPathWithRect : rect ];

        //fill path
        [ drawingPath fill ];
    } 
    
/*
    + (UIImage*) rotateImage : (UIImage*)image angle : (int)alpha
    {
        UIImage *existingImage = image;
        CGSize existingSize = [existingImage size];
        CGSize newSize = CGSizeMake(existingSize.height, existingSize.width);
        UIImage *rotatedImage = [[[UIImage alloc] initWithSize:newSize]
        autorelease];

        [rotatedImage lockFocus];
        [[NSGraphicsContext currentContext]
        setImageInterpolation:UIImageInterpolationNone];

        NSAffineTransform *rotateTF = [NSAffineTransform transform];
        CGPoint centerPoint = CGPointMake(newSize.width / 2,
        newSize.height / 2);

        //translate the image to bring the rotation point to the center
        //(default is 0,0 ie lower left corner)
        [rotateTF translateXBy:centerPoint.x yBy:centerPoint.y];
        [rotateTF rotateByDegrees:alpha];
        [rotateTF translateXBy:-centerPoint.x yBy:-centerPoint.y];
        [rotateTF concat];

        [existingImage drawAtPoint:CGPointZero fromRect:NSMakeRect(0, 0,
        newSize.width, newSize.height) operation:NSCompositeSourceOver
        fraction:1.0];

        [rotatedImage unlockFocus];

        return rotatedImage;
    }    
*/    
    @end
