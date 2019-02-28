# .irbrc
#
# require 'ap'
# load './1.rb'
# load './2.rb'
#
# def reload
#   load './1.rb'
#   load './2.rb'
# end
#
# def init1
#   input = File.read('b_lovely_landscapes.txt').split("\n")
#   @parsed21 = input[1..-1].each_with_index.map { |x, i| [i, x.split(' ')[2..-1]] }
#   @result21 = []
# end
#
# def init2
#   input = File.read('c_memorable_moments.txt').split("\n")
#   @parsed22 = input[1..-1].each_with_index.map { |x, i| x = x.split(' '); [i, x[1], x[2..-1]] }
#   @result22 = []
# end
#
# def write(filename = '', result = [])
#   File.write(filename, "#{result.count}\n#{result.map { |x| x.is_a?(Array) ? x.join(' ') : x }.join("\n")}")
# end

def process_sample2
  @previous ||= @parsed2.sample
  sample = @parsed2.max_by { |x| match(@previous[2], x[2]) }

  if sample[1] == 'V'
    vertical1 = get_best_match(sample)
    if vertical1.nil?
      @previous = @pre_previous
      @parsed2.delete(sample)
      return
    else
      sample = [sample, vertical1]
    end
    @previous = sample[0]
  end

  @result2 << (sample.map { |x| x.is_a?(Array) }.all? ? sample.map { |x| x[0] } : sample[0])
  @pre_previous = @previous
  @previous = (sample.map { |x| x.is_a?(Array) }.all? ? sample[1] : sample)
  sample.map { |x| x.is_a?(Array) }.all? ? sample.each { |x| @parsed2.delete(x) } : @parsed2.delete(sample)
end

def get_best_match(el)
  @parsed2.select { |x| x[1] == 'V' }.reject { |x| el == x }.max_by { |x| match(el[2], x[2]) }
end

def match(el1, el2)
  sum = el1 & el2
  diff1 = el1 - el2
  diff2 = el2 - el1
  [sum.size, diff1.size, diff2.size].min
end

def sample_loop2
  @deep = 0
  while @parsed2.count > 1
    process_sample2
    @deep += 1
  end
end
