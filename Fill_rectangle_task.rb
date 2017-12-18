
# Creator Nil Medvedev
# An example of interview task

class Picture
  # constructor
  def initialize(_m, n)
    @arr = Array.new(n) { Array.new(n) { 'O' } }
  end

  # show
  def print_picture
    @arr.each do |arr|
      arr.each do |item|
        print "#{item} "
      end
      print "\n"
    end
   end

  # edit array and print horizontal/vertical line with input value
  # i put "- 1" because for user picture begins from 1, 1 and not 0, 0
  def draw_vertical_line(x, y1, y2, value)
    x -= 1
    y1 -= 1
    y2 -= 1
    while y1 <= y2
      @arr[y1][x] = value
      y1 += 1
    end
   end

  def draw_horizontal_line(x1, x2, y, value)
    y -= 1
    x1 -= 1
    x2 -= 1
    while x1 <= x2
      @arr[y][x1] = value
      x1 += 1
    end
  end

  # edit by index
  def draw_by_index(x, y, value)
    x -= 1
    y -= 1
    @arr[y][x] = value
  end

  def pict_clear!
    @arr.each { |arr| arr.map! { |_value| value = 'O' } }
  end

  def set_target_color(x, y)
    @target_color = @arr[y][x]
  end

  def get_target_color
    @target_color
  end

  # std floodfill
  def floodfill(x, y, _target_color, replacement_color)
    stack = [[y, x]] # stack with indexes
    while stack.any?
      ix = stack.pop
      next if @arr[ix[0]].nil?
      next if @arr[ix[1]].nil?
      next if @arr[ix[0]][ix[1]].nil?
      next if @arr[ix[0]][ix[1]] == replacement_color
      @arr[ix[0]][ix[1]] = replacement_color
      stack.push([ix[1] + 1, ix[0]])
      stack.push([ix[1] - 1, ix[0]])
      stack.push([ix[1], ix[0] + 1])
      stack.push([ix[1], ix[0] - 1])
    end
  end
end

# ###############PUTS
session = true
puts 'Session started. You can start to enter commands.'
puts "
Commands
The editor supports 7 commands:
1. I M N. Create a new M x N image with all pixels coloured white (O).
2. C. Clears the table, setting all pixels to white (O).
3. L X Y C. Colours the pixel (X,Y) with colour C.
4. V X Y1 Y2 C. Draw a vertical segment of colour C in column X between rows Y1 and Y2
(inclusive).
5. H X1 X2 Y C. Draw a horizontal segment of colour C in row Y between columns X1 and X2
(inclusive).
6. F X Y C. Fill the region R with the colour C. R is defined as: Pixel (X,Y) belongs to R. Any other
pixel which is the same colour as (X,Y) and shares a common side with any pixel in R also belongs
to this region.
7. S. Show the contents of the current image
8. X. Terminate the session

Let's begin."

puts 'Enter parameters'
while session == true
  arr_input = gets.chomp.split
  if arr_input[0] == 'I' && arr_input.count == 3
    pict = Picture.new(arr_input[1].to_i, arr_input[2].to_i)
    puts 'Done.A picture created.'
  elsif arr_input[0] == 'L' && arr_input.count == 4
    pict.draw_by_index(arr_input[1].to_i, arr_input[2].to_i, arr_input[3])
    pict.print_picture
    puts 'Pixel printed'
  elsif arr_input[0] == 'V' && arr_input.count == 5
    pict.draw_vertical_line(arr_input[1].to_i, arr_input[2].to_i, arr_input[3].to_i, arr_input[4]) # x, y1, y2, c
    puts 'Line printed'
  elsif arr_input[0] == 'H' && arr_input.count == 5
    pict.draw_horizontal_line(arr_input[1].to_i, arr_input[2].to_i, arr_input[3].to_i, arr_input[4]) # x1, x2, y, c
    puts 'Line printed'
  elsif arr_input[0] == 'F' && arr_input.count == 4
    pict.set_target_color(arr_input[1].to_i - 1, arr_input[2].to_i - 1)
    pict.floodfill(arr_input[1].to_i - 1, arr_input[2].to_i - 1, pict.get_target_color, arr_input[3])
    puts 'Picture filled'
  elsif arr_input[0] == 'C' && arr_input.count == 1
    pict.pict_clear!
    puts 'Picture cleared'
  elsif arr_input[0] == 'S' && arr_input.count == 1
    pict.print_picture
  elsif arr_input[0] == 'X' && arr_input.count == 1
    session = false
    puts 'Bye!'
  else puts 'Wrong input. Try again.'
  end
end
