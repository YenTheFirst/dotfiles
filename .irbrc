require 'pp'

Signal.trap('SIGWINCH', proc {Readline.set_screen_size(*`stty size`.split.map(&:to_i)) })

class Object
  def pretty_methods
    methods.group_by {|m| self.method(m).owner}
  end
end
