#include "pencil.hpp"

namespace tool {

pencil_t::pencil_t()
    : _min_x{std::numeric_limits<float>::max()},
      _min_y{std::numeric_limits<float>::max()},
      _max_x{std::numeric_limits<float>::min()},
      _max_y{std::numeric_limits<float>::min()}
{
}

pencil_t::~pencil_t()
{
}

void pencil_t::start(const gui::layout::vec2_t &point)
{
    _min_x = fmin(_min_x, point.x);
    _min_y = fmin(_min_y, point.y);
    _max_x = fmin(_max_x, point.x);
    _max_y = fmin(_max_y, point.y);
    
    _path.push_back(point);
}

void pencil_t::add_point(const gui::layout::vec2_t &point)
{
    _min_x = fmin(_min_x, point.x);
    _min_y = fmin(_min_y, point.y);
    _max_x = fmax(_max_x, point.x);
    _max_y = fmax(_max_y, point.y);
    
    _path.push_back(point);
}

void pencil_t::draw(gui::builder_t &builder) const
{
    if(_path.size() < 2)
    {
        return;
    }
    
    builder.push_clip_rect({_min_x - 3,
                            _min_y - 3,
                            _max_x - _min_x + 6,
                            _max_y - _min_y + 6});
    
    builder.add_polyline(_path, {0xFF, 0xFF, 0x00, 0xFF}, 6);
    
    builder.pop_clip_rect();
}

} // tool
