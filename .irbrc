require 'ap'
load './1.rb'
load './2.rb'

def reload
  load './1.rb'
  load './2.rb'
end

def init1
  input = File.read('b_lovely_landscapes.txt').split("\n")
  @parsed1 = input[1..-1].each_with_index.map { |x, i| [i, x.split(' ')[2..-1]] }
  @result1 = []
end

def init2
  input = File.read('c_memorable_moments.txt').split("\n")
  @parsed2 = input[1..-1].each_with_index.map { |x, i| x = x.split(' '); [i, x[0], x[2..-1]] }
  @result2 = []
end

def write(filename = '', result = [])
  File.write(filename, "#{result.count}\n#{result.map { |x| x.is_a?(Array) ? x.join(' ') : x }.join("\n")}")
end
