/*  $Id:$
 *  =================================================================
 */
    
    enum SliverDirection
    {
        ESliverDirectionAscending,
        ESliverDirectionDescending,
        ESliverDirectionLeft,
        ESliverDirectionRight,
    };
    
    @interface LibSliverParticle : NSObject 
    {
        UIImage*    img;
        float       centerX;
        float       centerY;
        float       x;
        float       y;    
        int         angle;
        int         radius;
        int         sliverDirX;
        int         sliverDirY;
        float       deltaX;
        float       deltaY;
        float       speedY;
        BOOL        delay;
    }

    - (LibSliverParticle*) init : (int)aStartX : (int)aStartY : (UIImage*)aImg;

    - (UIImage*) getImage;

    - (float) getX;

    - (float) getY;
    
    - (void) animate;

    @end
