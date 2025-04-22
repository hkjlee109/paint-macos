#import "PaintView.h"

@implementation PaintView

- (instancetype)initWithFrame:(CGRect)frameRect device:(id<MTLDevice>)device {
    self = [super initWithFrame:frameRect device:device];
    if(self) {
        self.wantsLayer = YES;
        self.layer.opaque = NO;
        self.layer.backgroundColor = NSColor.clearColor.CGColor;

        self.colorPixelFormat = MTLPixelFormatBGRA8Unorm;
        self.clearColor = MTLClearColorMake(0.0, 0.0, 0.0, 0.0);
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}

@end
