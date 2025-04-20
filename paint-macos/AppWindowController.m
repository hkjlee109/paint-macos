#import "AppWindowController.h"

#import "AppWindow.h"
#import "PaintView.h"

@interface AppWindowController ()

@end

@implementation AppWindowController

- (id)init {
    self = [super init];
    if(self) {
        PaintView *view = [PaintView new];
                
        self.window = [AppWindow new];
        [self.window setContentView:view];
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
