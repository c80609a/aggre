# Добавляет возможность перебрать что-то перебираемое
# с помощью курсора, постранично
#
module CanPager
  def page(arr, pg, offset = 10)
    arr[((pg-1)*offset)..((pg*offset)-1)]
  end
end

# usage:
#
# class TestCanPager
#   include CanPager
#
#   def initialize
#     ptr   = 1
#     limit = 3
#     arr   = (1..11).to_a.map { (rand*99).to_i }.sort
#
#     puts 'limit = %s, arr = [%s] (arr.size = %s)' % [limit, arr * ',', arr.size]
#     while true
#       arr_page = page arr, ptr, limit
#       break if arr_page.nil? || arr_page.empty?
#       puts '---------------------< page %s ' % ptr
#       p arr_page
#       ptr += 1
#     end
#
#   end
#
# end
#
# TestCanPager.new
#
# :: example output::
#
# limit = 3, arr = [5,6,14,40,47,52,55,66,69,72,74] (arr.size = 11)
# ---------------------< page 1
# [5, 6, 14]
# ---------------------< page 2
# [40, 47, 52]
# ---------------------< page 3
# [55, 66, 69]
# ---------------------< page 4
# [72, 74]
#
