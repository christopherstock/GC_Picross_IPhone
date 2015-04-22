/*  $Id:$
 *  =================================================================
 */
        
    #import "Picross.h"
    #import "PicrossGame.h"
    #import "PicrossLevel.h"
    #import "PicrossResources.h"
    #import "PicrossState.h"
    #import "LibDebug.h"
    #import "LibSliver.h"
    #import "LibUtil.h"

    @implementation PicrossLevel

    NSMutableArray*         levelData       = nil;
    NSString*               levelCaption    = nil;

    - (void) initEasy
    {
        //create from img
        levelData    = [ self createLevelDataFromImage : EImgLevelEasy1 ];
        levelCaption = @"It's the letter 'F'.";
    }

    - (void) initMedium
    {
        //create from img
        levelData = [ self createLevelDataFromImage : EImgLevelMedium1 ];
        levelCaption = @"It's a sailboat.";
    }

    - (void) initHard
    {
        //create from img
        levelData = [ self createLevelDataFromImage : EImgLevelHard1 ];
        levelCaption = @"It's the Synapsy logo.";
    }
    
    - (NSMutableArray*) getLevelData
    {
        return levelData;
    };
    
    - (NSString*) getLevelCaption
    {
        return levelCaption;
    };
    
    - (void) chiselField : (int)selectorX : (int)selectorY
    {
        //chisel this field
        [ LibDebug out : @"Chisel field" ];
    
        //check current tile on this location
        NSMutableArray* line    = [ levelData objectAtIndex : selectorY ];
        NSNumber*       r       = [ line objectAtIndex : selectorX ];
        int             d       = [ r intValue ];
    
        switch ( d )
        {
            case ETileTypeFullOpen:
            {
                //nothing happens - already open
                break;
            }
            
            case ETileTypeFullClosedUnmarked:
            case ETileTypeFullClosedMarked:
            {
                //open tile
                [ line replaceObjectAtIndex : (NSUInteger)selectorX withObject : [ NSNumber numberWithInt : ETileTypeFullOpen ] ];
                
                //notify open
                [ [ [ singletonMainContext getState ] getGame ] notifyOpen : selectorX : selectorY ];
                
                break;
            }
            
            case ETileTypeEmptyMarked:
            case ETileTypeEmptyUnmarked:
            {
                //notify error
                [ [ [ singletonMainContext getState ] getGame ] notifyError ];
                break;
            }
        }
    }
    
    - (void) markField : (int)selectorX : (int)selectorY
    {
        //mark this field
        [ LibDebug out : @"Mark field" ];
    
        //check current tile on this location
        NSMutableArray* line    = [ levelData objectAtIndex : selectorY ];
        NSNumber*       r       = [ line objectAtIndex : selectorX ];
        int             d       = [ r intValue ];
    
        switch ( d )
        {
            case ETileTypeFullOpen:
            {
                //nothing happens - already open
                break;
            }
            
            case ETileTypeFullClosedUnmarked:
            {
                //mark tile
                [ line replaceObjectAtIndex : (NSUInteger)selectorX withObject : [ NSNumber numberWithInt : ETileTypeFullClosedMarked ] ];
                break;
            }
            
            case ETileTypeFullClosedMarked:
            {
                //unmark tile
                [ line replaceObjectAtIndex : (NSUInteger)selectorX withObject : [ NSNumber numberWithInt : ETileTypeFullClosedUnmarked ] ];
                break;
            }
            
            case ETileTypeEmptyMarked:
            {
                //unmark tile
                [ line replaceObjectAtIndex : (NSUInteger)selectorX withObject : [ NSNumber numberWithInt : ETileTypeEmptyUnmarked ] ];
                break;
            }

            case ETileTypeEmptyUnmarked:
            {
                //mark tile
                [ line replaceObjectAtIndex : (NSUInteger)selectorX withObject : [ NSNumber numberWithInt : ETileTypeEmptyMarked ] ];
                break;
            }
        }
    }
    
    - (NSMutableArray*) getNumbersCols
    {
        int rows = [ levelData count ];
        int cols = [ [ levelData objectAtIndex : 0 ] count ];
        NSMutableArray* ret = [ [ NSMutableArray alloc ] initWithCapacity : 0 ];

        //browe all columns
        for ( int i = 0; i < cols; ++i )
        {
            NSMutableArray* colNumbers = [ [ NSMutableArray alloc ] initWithCapacity : 0 ]; 
            BOOL blockLength = 0;
        
            //browse all rows of this column
            for ( int j = 0; j < rows; ++j )
            {
                switch ( [ [ [ levelData objectAtIndex : j ] objectAtIndex : i ] intValue ] )
                {
                    case ETileTypeFullClosedUnmarked:
                    {
                        ++blockLength;
                        break;
                    }
                    
                    case ETileTypeEmptyUnmarked:
                    {
                        if ( blockLength > 0 ) [ colNumbers addObject : [ NSNumber numberWithInt : blockLength ] ];
                        blockLength = 0;
                        break;
                    }
                }
            }
            
            if ( blockLength > 0 ) [ colNumbers addObject : [ NSNumber numberWithInt : blockLength ] ];

            //check if this col has no blocks - write 0 in this case
            if ( [ colNumbers count ] == 0 ) [ colNumbers addObject : [ NSNumber numberWithInt : 0 ] ];

            //add numbers for this column
            [ ret addObject : colNumbers ];
        }
        
        //return column numbers
        return ret;
    }

    - (NSMutableArray*) getNumbersRows
    {
        int rows = [ levelData count ];
        int cols = [ [ levelData objectAtIndex : 0 ] count ];
        NSMutableArray* ret = [ [ NSMutableArray alloc ] initWithCapacity : 0 ];

        //browe all rows
        for ( int i = 0; i < rows; ++i )
        {
            NSMutableArray* rowNumbers = [ [ NSMutableArray alloc ] initWithCapacity : 0 ]; 
            BOOL blockLength = 0;
        
            //browse all cols of this row
            for ( int j = 0; j < cols; ++j )
            {
                switch ( [ [ [ levelData objectAtIndex : i ] objectAtIndex : j ] intValue ] )
                {
                    case ETileTypeFullClosedUnmarked:
                    {
                        ++blockLength;
                        break;
                    }
                    
                    case ETileTypeEmptyUnmarked:
                    {
                        if ( blockLength > 0 ) [ rowNumbers addObject : [ NSNumber numberWithInt : blockLength ] ];
                        blockLength = 0;
                        break;
                    }
                }
            }
            
            if ( blockLength > 0 ) [ rowNumbers addObject : [ NSNumber numberWithInt : blockLength ] ];

            //check if this row has no blocks - write 0 in this case
            if ( [ rowNumbers count ] == 0 ) [ rowNumbers addObject : [ NSNumber numberWithInt : 0 ] ];

            //add numbers for this row
            [ ret addObject : rowNumbers ];
        }
        
        //return row numbers
        return ret;
    }
    
    - (NSMutableArray*) createLevelDataFromImage : (Images)img    
    {
        //pick image
        UIImage* image = [ [ singletonMainContext getResources ] getImage : img ];
        
        //get dimensions
        int width  = (int)[ image size ].width;
        int height = (int)[ image size ].height;
        
        //get pixel data
        //NSBitmapImageRep* raw_img = [ NSBitmapImageRep imageRepWithData : [ image TIFFRepresentation ] ];

        //create return array
        NSMutableArray* ret = [ [ NSMutableArray alloc ] initWithCapacity : 0 ];
        
        
        
        CGImageRef cgimage = image.CGImage;
        CGDataProviderRef provider = CGImageGetDataProvider(cgimage);
        NSData* data = (id)CGDataProviderCopyData(provider);
        [data autorelease];
        size_t bpr = CGImageGetBytesPerRow(cgimage);
        size_t bpp = CGImageGetBitsPerPixel(cgimage);
        size_t bpc = CGImageGetBitsPerComponent(cgimage);
        size_t bytes_per_pixel = bpp / bpc;
        
        const uint8_t* bytes = [data bytes];
        int pixelNum = height * bpr + width * bytes_per_pixel;
        const uint8_t* pixel = &bytes[pixelNum];
        
        [ LibDebug out : @">>>> SHOW 1ST TILE:" ]; 
        [ LibDebug out : [ LibUtil intToString : pixel[ 0 ] ] ]; 
        [ LibDebug out : [ LibUtil intToString : pixelNum ] ]; 
        [ LibDebug out : [ LibUtil intToString : sizeof( bytes ) ] ]; 
        
    for ( size_t row = 0; row < height; row++ )
    {
        NSMutableArray* arr = [ [ NSMutableArray alloc ] initWithCapacity : 0 ];
    
        for ( size_t col = 0; col < width; col++ )
        {
            const uint8_t* pixel =
                &bytes[row * bpr + col * bytes_per_pixel];

            printf("(");
            
            BOOL WHITE_PIXEL = YES;
            
            for(size_t x = 0; x < bytes_per_pixel; x++)
            {
                printf("%.2X", pixel[x]);
                
                if ( pixel[x] == 0xff ) WHITE_PIXEL = NO;
                
                if( x < bytes_per_pixel - 1 )
                    printf(",");
            }

            printf(")");
            if( col < width - 1 )
                printf(", ");
                
                
                //check white pixel
                if ( WHITE_PIXEL ) //[ color isEqual : black ] )
                {
                    [ arr addObject : [ NSNumber numberWithInt : ETileTypeFullClosedUnmarked ] ];
                }
                else 
                {
                    [ arr addObject : [ NSNumber numberWithInt : ETileTypeEmptyUnmarked ] ];
                }                
        }
        
        [ ret addObject : arr ];

        printf("\n");
    }
        
        
        
        
        /*
        //browse rows
        for ( int i = 0; i < height; ++i )
        {
            NSMutableArray* arr = [ [ NSMutableArray alloc ] initWithCapacity : 0 ];
            
            //browse cols
            for ( int j = 0; j < width; ++j )
            {
                //check pixel
                //UIColor* color = [ [ raw_img colorAtX : j y : i ] colorUsingColorSpaceName : NSCalibratedRGBColorSpace ];
                //UIColor* black = [ [ UIColor blackColor ] colorUsingColorSpaceName : NSCalibratedRGBColorSpace ];
                
                
                
                
                
                if ( true ) //[ color isEqual : black ] )
                {
                    [ arr addObject : [ NSNumber numberWithInt : ETileTypeFullClosedUnmarked ] ];
                }
                else 
                {
                    [ arr addObject : [ NSNumber numberWithInt : ETileTypeEmptyUnmarked ] ];
                }
            }
        
            [ ret addObject : arr ];
        }
*/
        return ret;
    }

    @end
