#import "AppWindow.h"

@implementation AppWindow

- (instancetype)initWithContentRect:(NSRect)contentRect styleMask:(NSWindowStyleMask)style backing:(NSBackingStoreType)backingStoreType defer:(BOOL)flag {
    self = [super initWithContentRect:contentRect
                            styleMask:NSWindowStyleMaskBorderless
                              backing:backingStoreType
                                defer:flag];
    
    if(self) {
        self.level = NSFloatingWindowLevel;
        self.opaque = NO;
        self.backgroundColor = NSColor.clearColor;
        
        [self setIgnoresMouseEvents:NO];
    }
    return self;
}

- (BOOL)canBecomeKeyWindow {
    return YES;
}

@end
