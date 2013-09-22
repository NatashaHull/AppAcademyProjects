require 'set'

module Searchable
	def a_star_search(end_node)
		frontier = [self]
		closed_set = Set[self]
		path[self] = self
		until frontier.empty?
			frontier.sort_by! { |relative| path[relative] + manhattan_distance(relative.value, end_node) }
			current_node = frontier.shift
			return path[current_node].map(&:value) if current_node.value == end_node
			current_node.relatives.each do |relative|
				next if closed_set.include?(relative)
				if frontier.include?(relative)
					if (path[current_node].length + 1) < path[relative]
						path[relative] = path[current_node] + [relative]
					end
				else
					path[relative] = path[current_node] + [relative]
					closed_set << relative
					frontier << relative
				end
			end
		end
		false
	end

	def different_letters(current_value, goal)
		correct_letters = 0
		0.upto(goal-1) do |i|
			correct_letters += 1 if current_value[1] == goal[1]
		end
		goal.length - correct_letters
	end
end

#Here I create a graph data structure to contain graph information
class GraphNode
	include Searchable
	attr_reader :relatives
	@@values = {}

	def initialize(value)
		@value = value
		@relatives = []
		@@values_hash[value] = self
	end

	def add_relatives(relative)
		return @relatives if @relatives.include?(relative)
		new_relative = include?(relative) ? find_by_value(relative) : GraphNode.new(relative)
		@relatives << new_relative
		new_relative.add_relatives(self)
	end

	def self.include?(value)
		@@values.keys.include?(value)
	end

	def self.find_by_value(value)
		@@values[value]
	end
end

class WordChain
	DICTIONARY = File.readlines('dictionary.txt').map(&:chomp)
	attr_reader :word_graph

	def initialize(start_word)
		@start_word = start_word
		@word_graph = GraphNode.new(start_word)
	end

	def build_word_graph
		relative_words = [@word_graph]
		closed_set = Set[@word_graph]
		until frontier.empty?
			current_node = frontier.shift
			current_word = current_node.value
			find_nearby_words(current_word).each do |new_word|
				new_node = current_node.add_relatives(new_word)
				unless closed_set.include?(new_node)
					relative_words << new_node
					closed_set << new_node
				end
			end
		end
	end

	def find_nearby_words(word)
		nearby_words = []
		(0..word.length-1).each do |letter_i|
			("a".."z").each do |letter|
				new_word = current_word.dup
				new_word[letter_i] = letter
				nearby_words << new_word if DICTIONARY.include?(new_word) && new_word != word
			end
		end
		nearby_words
	end

	def word_chain(end_node)
		@word_graph.a_star_search(end_node)
	end
end

##Test for graphs and the searchable module
start_node = GraphNode.new("test")
start_node.add_relatives("rest")
start_node.add_relatives("pest")

p start_node.value
p start_node.relatives.map(&:value)
p start_node.relatives[0].relatives.map(&:value)

#Testing include
p GraphNode.include?("test")
p GraphNode.include?("rest")
p GraphNode.include?("pest")
p GraphNode.include?("insect")

#Testing find_by_value
p start_node == GraphNode.find_by_value("test")
p start_node.relatives[0] == GraphNode.find_by_value("rest")
p start_node.relatives[0] == GraphNode.find_by_value("pest")
p start_node == GraphNode.find_by_value("pest")