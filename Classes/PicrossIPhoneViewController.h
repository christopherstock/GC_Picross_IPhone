/*  $Id:$
 *  =================================================================
 */

    #import <UIKit/UIKit.h>

    @class PicrossIPhoneView;

    @interface PicrossIPhoneViewController : UIViewController 
    {
    }

    /********************************************************************
    *   A reference to the singleton main view.
    ********************************************************************/
    extern      PicrossIPhoneView*                  singletonMainView;

    extern      PicrossIPhoneViewController*        singletonMainViewController;

    @end
