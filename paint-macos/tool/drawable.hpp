#pragma once

#include <gui/builder.hpp>
#include <gui/layout/vec.hpp>
#include <vector>

namespace tool {

class drawable_t
{
public:
    drawable_t() {};
    virtual ~drawable_t() {};
    virtual void start(const gui::layout::vec2_t &point) = 0;
    virtual void add_point(const gui::layout::vec2_t &point) = 0;
    virtual void draw(gui::builder_t &builder) const = 0;
    
protected:
    float _min_x;
    float _min_y;
    float _max_x;
    float _max_y;
};

} // tool
