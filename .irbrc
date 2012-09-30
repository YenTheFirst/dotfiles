IRB.conf[:AUTO_INDENT]=true
require 'pp'
require 'irb/completion'

#fix terminal resizing
Signal.trap('SIGWINCH', proc {Readline.set_screen_size(*`stty size`.split.map(&:to_i)) })

class Object
	def pretty_methods(raw_classes=true)
		meth = methods.group_by {|m| method(m).owner}
		parents = self.class.ancestors
		sorted = meth.map {|k,v| [k,v.sort]}.sort_by {|(k,v)| parents.index(k) || -1}
		sorted.map! {|(k,v)| [k.to_s,v]} unless raw_classes
		Hash[*sorted.flatten(1)]
	end
end
