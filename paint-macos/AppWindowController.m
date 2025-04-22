#import "AppWindowController.h"

#import "AppWindow.h"
#import "PaintViewController.h"

@interface AppWindowController ()

@end

@implementation AppWindowController

- (id)init {
    self = [super init];
    if(self) {
        PaintViewController *controller = [PaintViewController new];
                
        self.window = [AppWindow new];
        [self.window setContentViewController:controller];
        [self.window center];
        
        NSScreen *screen = [NSScreen mainScreen];
        if(screen) {
            [self.window setFrame:screen.frame display:YES];
        }
    }
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
}

@end
