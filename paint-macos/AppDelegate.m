
#import "AppDelegate.h"
#import "AppWindowController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate {
    AppWindowController* windowController;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    if(windowController == nil) {
        windowController = [AppWindowController new];
    }
    
    [windowController.window orderFront:self];
    
    NSMenu *mainMenu = [NSMenu new];
    
    NSMenuItem *appMenuItem = [NSMenuItem new];
    [mainMenu addItem:appMenuItem];

    NSMenu *appMenu = [NSMenu new];
    NSString *appName = [[NSProcessInfo processInfo] processName];
    NSMenuItem *quitMenuItem = [[NSMenuItem alloc] initWithTitle:[NSString stringWithFormat:@"Quit %@", appName]
                                                          action:@selector(terminate:)
                                                   keyEquivalent:@"q"];
    [appMenu addItem:quitMenuItem];
    [appMenuItem setSubmenu:appMenu];

    [NSApp setMainMenu:mainMenu];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
}

- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
    return YES;
}

@end
