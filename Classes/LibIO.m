/*  $Id:$
 *  =================================================================
 */

    #import "LibIO.h"

    @implementation LibIO

    + (UIImage*) loadImage : (NSString*)symbolName imgType:(NSString*)imgType
    {
        NSString* imageName = [[NSBundle mainBundle] pathForResource : symbolName ofType : imgType ];
        UIImage*  tempImage = [[UIImage alloc] initWithContentsOfFile : imageName ];
        
        return tempImage;
    }

    @end
