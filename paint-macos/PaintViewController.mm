#import "PaintViewController.h"
#import <MetalKit/MetalKit.h>

#include <gui/context.hpp>
#include <gui/mtl_renderer.hpp>
#include <tool/pencil.hpp>
#include <memory>


@interface PaintViewController() <NSWindowDelegate, MTKViewDelegate>

@end

@implementation PaintViewController {
    std::unique_ptr<gui::mtl_renderer_t> _renderer;
    
    std::vector<tool::pencil_t> _objects;
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
    _objects.emplace_back();
}

- (void)mouseUp:(NSEvent *)event {
    NSLog(@"# mouseUp");
}

- (void)mouseDragged:(NSEvent *)event {
    NSLog(@"# mouseDragged");
    _objects.back().add_point({static_cast<float>(event.locationInWindow.x),
                               static_cast<float>(self.view.frame.size.height - event.locationInWindow.y)});
    
    [self.view setNeedsDisplay:YES];
}

#pragma mark MTKViewDelegate

- (void)drawInMTKView:(nonnull MTKView *)view {
    NSLog(@"# drawInMTKView");
    gui::context_t ctx;

    //    ctx.renderer = _renderer.get();
    ctx.surface_handle = (gui::surface_handle_t)(__bridge CA::MetalDrawable *)self.mtkView.currentDrawable;

    ctx.display_size = gui::layout::size_t{(float)(self.view.bounds.size.width),
                                           (float)(self.view.bounds.size.height)};

    CGFloat scale = self.view.window.screen.backingScaleFactor ?: NSScreen.mainScreen.backingScaleFactor;
    ctx.display_scale = gui::layout::vec2_t{(float)scale, (float)scale};

    _renderer->begin_draw(ctx);
    
    for(const tool::pencil_t &object : _objects)
    {
        object.draw(_renderer->builder);
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
