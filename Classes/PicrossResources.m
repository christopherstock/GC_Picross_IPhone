/*  $Id:$
 *  =================================================================
 */

    #import "PicrossResources.h"
    #import "LibDebug.h"
    #import "LibIO.h"
    #import "LibUtil.h"

    @implementation PicrossResources

    NSMutableArray*     images      = nil;

    - (void) loadImages
    {
        [ LibDebug out : @"PicrossResources: loadImages START" ];        
        
        //load images into array
        images = [ [ NSMutableArray alloc] initWithCapacity : (NSUInteger)EImgIndices ];          
        for ( int i = 0; i < EImgIndices; ++i )
        {
            [ images addObject : [ LibIO loadImage : [ LibUtil intToString : i ] imgType:@"png" ] ];
        }
        [ LibDebug out : @"PicrossResources: loadImages END" ];        
    }
    
    - (UIImage*) getImage : (Images) index
    {
        return [ images objectAtIndex : index ];
    }

    @end
