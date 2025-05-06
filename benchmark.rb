require 'benchmark'
symbol_hash = { foo: 'value' }
string_hash = { 'foo' => 'value' }
integer_hash = { 1 => 'value' }

n = 100_000_000 
Benchmark.bmbm do |x|
  x.report('Symbol') { n.times { symbol_hash[:foo] } }
  x.report('String') { n.times { string_hash['foo'] } }
  x.report('Integer') { n.times { integer_hash[1] } }
end
