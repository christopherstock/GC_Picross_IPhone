/*  $Id:$
 *  =================================================================
 */

    #import <UIKit/UIKit.h>

    @class PicrossIPhoneViewController;

    @interface PicrossIPhoneAppDelegate : NSObject <UIApplicationDelegate> 
    {
        UIWindow                    *window;
        PicrossIPhoneViewController *viewController;
    }

    @property (nonatomic, retain) IBOutlet UIWindow *window;
    @property (nonatomic, retain) IBOutlet PicrossIPhoneViewController *viewController;

    @end
