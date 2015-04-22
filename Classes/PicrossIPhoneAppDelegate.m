/*  $Id:$
 *  =================================================================
 */

    #import "LibDebug.h"
    #import "PicrossIPhoneAppDelegate.h"
    #import "PicrossIPhoneViewController.h"

    @implementation PicrossIPhoneAppDelegate

    @synthesize window;
    @synthesize viewController;

    #pragma mark -
    #pragma mark Application lifecycle

    - (BOOL) application : (UIApplication*) application didFinishLaunchingWithOptions : (NSDictionary*) launchOptions 
    {    
        //override point for customization after application launch.
        [ LibDebug out : @"PicrossIPhoneAppDelegate::didFinishLaunchingWithOptions" ];

        //hide top status bar
        [ [ UIApplication sharedApplication ] setStatusBarHidden : YES ];

        //set the view controller as the window's root view controller and display.
        self.window.rootViewController = self.viewController;
        [ self.window makeKeyAndVisible ];

        return YES;
    }

    /**********************************************************************************************
    *   Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    *   Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    **********************************************************************************************/
    - (void) applicationWillResignActive : (UIApplication*) application 
    {
        [ LibDebug out : @"PicrossIPhoneAppDelegate::applicationWillResignActive" ];
    }

    /**********************************************************************************************
    *   Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    *   If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
    **********************************************************************************************/
    - (void) applicationDidEnterBackground : (UIApplication*) application 
    {
        [ LibDebug out : @"PicrossIPhoneAppDelegate::applicationDidEnterBackground" ];
    }

    /**********************************************************************************************
    *   Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
    **********************************************************************************************/
    - (void) applicationWillEnterForeground : (UIApplication*) application 
    {
        [ LibDebug out : @"PicrossIPhoneAppDelegate::applicationWillEnterForeground" ];
    }

    /**********************************************************************************************
    *   Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    **********************************************************************************************/
    - (void) applicationDidBecomeActive : (UIApplication*)application 
    {
        [ LibDebug out : @"PicrossIPhoneAppDelegate::applicationDidBecomeActive" ];
    }

    /**********************************************************************************************
    *   Called when the application is about to terminate. See also applicationDidEnterBackground.
    **********************************************************************************************/
    - (void) applicationWillTerminate : (UIApplication*) application 
    {
        [ LibDebug out : @"PicrossIPhoneAppDelegate::applicationWillTerminate" ];
    }

    #pragma mark -
    #pragma mark Memory management

    /**********************************************************************************************
    *   Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
    **********************************************************************************************/
    - (void) applicationDidReceiveMemoryWarning : (UIApplication*) application 
    {
        [ LibDebug out : @"PicrossIPhoneAppDelegate::applicationDidReceiveMemoryWarning" ];
    }

    /**********************************************************************************************
    *   Cleans up all resources this class holds.
    **********************************************************************************************/
    - (void) dealloc 
    {
        [ LibDebug out : @"PicrossIPhoneAppDelegate::dealloc" ];
        
        [ viewController release ];
        [ window         release ];
        [ super          dealloc ];
    }

    @end
