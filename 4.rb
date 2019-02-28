def init
  input = File.read('e_shiny_selfies.txt').split("\n")
  @parsed = input[1..-1].each_with_index.map { |x, i| [i, x.split(' ')[2..-1]] }
  @result = []
end

def write(filename = '')
  result = @result.each_slice(2).to_a
  File.write(filename, "#{result.count}\n#{result.map { |x| x.is_a?(Array) ? x.join(' ') : x }.join("\n")}")
end

def process_sample
  @previous ||= @parsed.sample
  sample = @parsed.sample(@parsed.count / 10).max_by { |x| @previous == x ? 0 : match(@previous[1], x[1]) }
  return if @previous == sample

  @result << sample[0]
  @previous = sample
  @parsed.delete(sample)
end

def match(el1, el2)
  sum = el1 & el2
  diff1 = el1 - el2
  diff2 = el2 - el1
  [sum.size, diff1.size, diff2.size].min
end

def sample_loop
  while @parsed.count > 1
    process_sample
  end
end
