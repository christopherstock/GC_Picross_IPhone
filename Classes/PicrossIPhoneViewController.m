/*  $Id:$
 *  =================================================================
 */

    #import "LibDebug.h"
    #import "Picross.h"
    #import "PicrossIPhoneView.h"
    #import "PicrossIPhoneViewController.h"

    @implementation PicrossIPhoneViewController

    PicrossIPhoneView*              singletonMainView           = nil;
    PicrossIPhoneViewController*    singletonMainViewController = nil;

    // The designated initializer. Override to perform setup that is required before the view is loaded.
    - (id) initWithNibName : (NSString*) nibNameOrNil bundle : (NSBundle*) nibBundleOrNil 
    {
        [ LibDebug out : @"initWithNibName" ]; 

        self = [ super initWithNibName : nibNameOrNil bundle : nibBundleOrNil ];
        if ( self ) 
        {
            // Custom initialization
        }
        return self;
    }

    // Implement loadView to create a view hierarchy programmatically, without using a nib.
    - (void) loadView 
    {
        [ LibDebug out : @"PicrossIPhoneViewController::loadView" ]; 
    }

    // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
    - (void) viewDidLoad 
    {
        [ LibDebug out : @"PicrossIPhoneViewController::View did load" ]; 
        [ LibDebug out : @"Welcome to the PICROSS project" ];

        //invoke super construct
        [ super viewDidLoad];

        //reference singleton instance
        singletonMainViewController = self;

        [ LibDebug out : @"Create main view" ];
        
        //create main view
        singletonMainView = [ [ PicrossIPhoneView alloc ] initWithFrame : [ [ UIScreen mainScreen ] bounds ] ];

        //set content mode to redraw ( on rotating canvas )
        [ singletonMainView setContentMode : UIViewContentModeRedraw ];

        [ LibDebug out : @"Add main view" ];

        //add main view
        self.view = singletonMainView;
        
      //[ self.view addSubview : singletonMainView ];

        [ LibDebug out : @"Done." ];


        //instanciate and init main-context
        singletonMainContext = [ Picross alloc ];
        [ singletonMainContext init : singletonMainView ];            

/*        
        int width  = self.view.bounds.size.width;
        int height = self.view.bounds.size.height;
        NSLog( @"width  >> %d", width  );
        NSLog( @"height >> %d", height );
        
        
        
        //release the view ?
        [ LibDebug out : @"View will be released" ];
        [ singletonMainView release ];
*/
    }        

/*
    // Override to allow orientations other than the default portrait orientation.
    - (BOOL) shouldAutorotateToInterfaceOrientation : (UIInterfaceOrientation) interfaceOrientation 
    {
        // Return YES for supported orientations
        return ( interfaceOrientation == UIInterfaceOrientationPortrait );
    }
*/
    - (void) didReceiveMemoryWarning 
    {
        // Releases the view if it doesn't have a superview.
        [ super didReceiveMemoryWarning ];
        
        // Release any cached data, images, etc that aren't in use.
    }

    - (void) viewDidUnload 
    {
        [ LibDebug out : @"View did unload" ];

        // Release any retained subviews of the main view.
        // e.g. self.myOutlet = nil;
    }

    - (void) dealloc 
    {
        [ super dealloc ];
    }

    @end
