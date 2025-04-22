#pragma once

#include "drawable.hpp"

#include <gui/builder.hpp>
#include <gui/layout/vec.hpp>
#include <vector>

namespace tool {

class pencil_t : public drawable_t
{
public:
    pencil_t();
    virtual ~pencil_t();
    
    virtual void start(const gui::layout::vec2_t &point) override;
    virtual void add_point(const gui::layout::vec2_t &point) override;
    virtual void draw(gui::builder_t &builder) const override;
    
private:
    std::vector<gui::layout::vec2_t> _path;
    
    float _min_x;
    float _min_y;
    float _max_x;
    float _max_y;
};

} // tool
