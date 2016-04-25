##### Author: Dipankar Achinta, 2015 #####
######################################## Actual Worker Class Below ########################################

# The worker class that will search through the data space
class SearchSpaceWorker
    # All attributes and properties of the worker class instances
	attr_reader :search_space, :default_index, :curr_key, :search_active
	
	# Initialize the Worker with the search space
    def initialize(search_space)
	    @search_space = search_space
	end
	
	# Method to find the index for a particular key
	def get_index_for(this_key, having_size_of_search_space)
	    this_key % having_size_of_search_space
	end
	
	# Set the flags to indicate search is on
	def set_flags
	    @search_active = true
	end
	
	# Reset the flags before exit
	def reset_flags
	    @search_active = false
	end
	
	# View the search status
	def search_active?
        search_active
	end
	
	# View the search space
	def view_search_space
	    search_space
	end
	
	# View the default index where the key should be present
	def view_default_index_for_key
	    default_index
	end
	
	# View the key to search
	def view_curr_key_to_search
	    curr_key
	end
	
	# Start the search for the specified key
	def searching(key)
	    set_flags # Initialize search environment
		@curr_key = key # Key to search
		@default_index = get_index_for(curr_key, search_space.size) # Get the default index(location) of the key in the search space
	    search_diagnosis # Perform diagnosis
		if search_space.[](default_index).member?(curr_key) then
		    reset_flags # Reset the worker state
		    "Key(#{curr_key}) found at index: #{default_index}"
		elsif search_space.[](default_index).member?(nil) then
		    reset_flags # Reset the worker state
		    "Key(#{curr_key}) not present in the hash table"
		else
		    apply_temporary_config # Apply the key at default index position, temporarily
			search_diagnosis # Perform diagnosis
		    forward_search(default_index)
		end
	end
	 
	# View the state of the search space and search worker
	def search_diagnosis(curr_index = nil)
		curr_index ||= view_default_index_for_key # Set index for diagnosis
	    print "*" * 10
		print " \#\{search_active?: #{search_active}, default_index: #{view_default_index_for_key}, \
key_to_search: #{view_curr_key_to_search}, current_index: #{curr_index}, current_search_space: #{view_search_space}\} "
		puts "*" * 10
	end
	
	# Temporarily store the key in that index
	def apply_temporary_config
	    search_space.[](default_index).push(curr_key) # Just to make it show explicit
	end
	
	# Remove the key that was temporarily stored at the default location, either the key was found or not found
	def remove_temporary_config
	    search_space.[](default_index).delete(curr_key)
	end
	
	# Clear the worker state and relieve it
	def clear_worker_state(index_to_search)
	    remove_temporary_config # Un-apply the previously applied key at the default location or index
		search_diagnosis(index_to_search) # Perform diagnosis
		reset_flags # Reset the worker state
	end
	
	# Checks if a full wrap-around search was performed and then the key was found
	def looped(curr_index)
	    curr_index == default_index
	end
	
	# Perform the forward search and wrap around
	def forward_search(index_to_search)
	    index_to_search = (index_to_search + 1) % search_space.size
		loop do
		    search_diagnosis(index_to_search) # Perform diagnosis
			if search_space.[](index_to_search).member?(curr_key)
				clear_worker_state(index_to_search) # Relieve worker
				return "Key(#{curr_key}) not present in the hash table" if looped(index_to_search)
				return "Key(#{curr_key}) found at index: #{index_to_search}"
			elsif search_space.[](index_to_search).member?(nil) then
				clear_worker_state(index_to_search) # Relieve worker
				return "Key(#{curr_key}) not present in the hash table"
			end
			index_to_search = (index_to_search + 1) % search_space.size
		end
		search_diagnosis(index_to_search) # Perform diagnosis
		clear_worker_state(index_to_search) # Relieve worker
		"Key(#{curr_key}) not present in the hash table"
	end
end

######################################## Actual Worker Class Above ########################################
# Utility for pretty printing
def formatter(reverse = false)
    if reverse then
        puts
	    puts "$" * 40
    else
	    puts "$" * 40
	    puts
	end
end

# Test the worker
hash_table = [[14], [nil], [32], [18], [nil], [5], [20], [22], [nil], [9], [nil], [26], [12], [nil], [29]]
search_worker = SearchSpaceWorker.new(hash_table)
# Formatting Utility
formatter
puts search_worker.searching(50)
# Formatting Utility
formatter(true)

######################################## To be implemented ########################################
=begin
def SearchSpace < Array
    attr_reader :total_elements
	# Specialized initialize for constructor call
    def initialize(element_count, space_increment_factor, space_refactor_switch = false)
	    super(element_count * space_increment_factor) unless space_refactor_switch # Execute if false, want space re-factoring
		super(element_count) if space_refactor_switch # Execute if true, don't want space re-factoring, go with default!
		@total_elements = element_count
	end
	
	def seed_space(max_val, manual = false)
		if manual then
		else
		    seed_vals = []
		    total_elements.times.map { seed_vals.push(rand(max_val)) }
			insert_into_index(seed_vals)
		end
	end
	
	def insert_into_index(get_seed_arr) 
	end
end
=end