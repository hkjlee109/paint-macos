#import "PaintViewController.h"
#import <MetalKit/MetalKit.h>

#include <gui/context.hpp>
#include <gui/mtl_renderer.hpp>
#include <tool/drawable.hpp>
#include <tool/pencil.hpp>
#include <memory>


@interface PaintViewController() <NSWindowDelegate, MTKViewDelegate>

@end

@implementation PaintViewController {
    std::unique_ptr<gui::mtl_renderer_t> _renderer;
    std::vector<std::unique_ptr<tool::drawable_t>> _drawables;
}

- (MTKView *)mtkView {
    return (MTKView *)self.view;
}

- (CAMetalLayer *)mtkLayer {
    return (CAMetalLayer *)self.mtkView.layer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mtkView.device = MTLCreateSystemDefaultDevice();
    self.mtkView.enableSetNeedsDisplay = YES;
    self.mtkView.delegate = self;
    
    self.mtkView.wantsLayer = YES;
    self.mtkLayer.opaque = NO;
    self.mtkLayer.backgroundColor = NSColor.clearColor.CGColor;

    self.mtkView.colorPixelFormat = MTLPixelFormatBGRA8Unorm;
    self.mtkView.clearColor = MTLClearColorMake(0.0, 0.0, 0.0, 0.0);
    
    _renderer = std::make_unique<gui::mtl_renderer_t>((__bridge MTL::Device *)self.mtkView.device);
}

- (void)viewWillAppear {
    [super viewWillAppear];
    self.view.window.delegate = self;
}

- (void)loadView {
    self.view = [[MTKView alloc] initWithFrame:CGRectZero];
}

- (void)mouseDown:(NSEvent *)event {
    NSLog(@"# mouseDown");
    _drawables.push_back(std::make_unique<tool::pencil_t>());
    _drawables.back()->start({static_cast<float>(event.locationInWindow.x),
                              static_cast<float>(self.view.frame.size.height - event.locationInWindow.y)});
}

- (void)mouseUp:(NSEvent *)event {
    NSLog(@"# mouseUp");
}

- (void)mouseDragged:(NSEvent *)event {
    NSLog(@"# mouseDragged");
    _drawables.back()->add_point({static_cast<float>(event.locationInWindow.x),
                                  static_cast<float>(self.view.frame.size.height - event.locationInWindow.y)});

    [self.view setNeedsDisplay:YES];
}

#pragma mark MTKViewDelegate

- (void)drawInMTKView:(nonnull MTKView *)view {
    NSLog(@"# drawInMTKView");
    gui::context_t ctx;

    ctx.surface_handle = (gui::surface_handle_t)(__bridge CA::MetalDrawable *)self.mtkView.currentDrawable;

    ctx.display_size = gui::layout::size_t{(float)(self.view.bounds.size.width),
                                           (float)(self.view.bounds.size.height)};

    CGFloat scale = self.view.window.screen.backingScaleFactor ?: NSScreen.mainScreen.backingScaleFactor;
    ctx.display_scale = gui::layout::vec2_t{(float)scale, (float)scale};

    _renderer->begin_draw(ctx);
    
    for(const auto &drawable : _drawables)
    {
        drawable->draw(_renderer->builder);
    }
    
    _renderer->end_draw();
}

- (void)mtkView:(nonnull MTKView *)view drawableSizeWillChange:(CGSize)size {
    NSLog(@"# mtkView drawableSizeWillChange");
}

#pragma mark NSWindowDelegate

- (void)windowWillClose:(NSNotification *)notification {
    NSLog(@"# windowWillClose");
}

@end
