/*  $Id:$
 *  =================================================================
 */

    @interface LibSound : NSObject 
    {
    }

  //+ (Sound*) playSound : (NSString*)fileName : (BOOL)loop;

    @end

/*

// Initialize
CFBundleRef mainBundle;
mainBundle = CFBundleGetMainBundle ();

// Init each sound
CFURLRef      tapURL;
SystemSoundID tapSound;
tapURL = CFBundleCopyResourceURL(mainBundle, CFSTR("tap"), CFSTR("aif"), NULL);
AudioServicesCreateSystemSoundID(tapURL, &tapSound);

// Play the sound async
AudioServicesPlaySystemSound(tapSound);


*/
