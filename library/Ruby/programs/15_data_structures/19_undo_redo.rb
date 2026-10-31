# Undo and redo stacks for a text editor.
class Editor
  attr_reader :text

  def initialize
    @text = +""
    @undo = []
    @redo = []
  end

  def type(s) = apply([:insert, @text.length, s])
  def delete_last(n) = apply([:delete, @text.length - n, @text[-n..]])

  def undo
    cmd = @undo.pop or return self
    reverse(cmd)
    @redo.push(cmd)
    self
  end

  def redo
    cmd = @redo.pop or return self
    run(cmd)
    @undo.push(cmd)
    self
  end

  private

  def apply(cmd)
    run(cmd)
    @undo.push(cmd)
    @redo.clear
    self
  end

  def run((kind, pos, s)) = kind == :insert ? @text.insert(pos, s) : @text[pos, s.length] = ""
  def reverse((kind, pos, s)) = kind == :insert ? @text[pos, s.length] = "" : @text.insert(pos, s)
end

e = Editor.new
e.type("Hello").type(", world").type("!!!")
puts e.text
e.delete_last(3)
puts e.text
e.undo
puts e.text
e.undo.undo
puts e.text
e.redo
puts e.text
e.type(" there")
puts e.text
e.redo
puts e.text
