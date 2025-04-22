#pragma once

#include <gui/builder.hpp>
#include <gui/layout/vec.hpp>
#include <vector>

namespace tool {

class pencil_t
{
public:
    pencil_t();
    ~pencil_t();
    
    void add_point(const gui::layout::vec2_t &point);
    void draw(gui::builder_t &builder) const;
    
private:
    std::vector<gui::layout::vec2_t> _path;
    
    float _min_x;
    float _min_y;
    float _max_x;
    float _max_y;
};

} // tool
