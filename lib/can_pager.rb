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
# ptr   = 1
# limit = 3
# arr   = [...]
#
# while true
#   arr_page = page arr, ptr, limit
#   puts arr_page
#   break if arr_page.empty?
#   ptr += 1
#   puts '-------'
# end
