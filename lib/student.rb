require 'pry'

class Student

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = "CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY, name TEXT, grade TEXT);"
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students;"
    DB[:conn].execute(sql)
  end

  def save
    sql = "INSERT INTO students (name, grade) VALUES (?, ?);"
    DB[:conn].execute(sql, name, grade)
    sql = "SELECT last_insert_rowid() FROM students;"
    @id = DB[:conn].execute(sql).flatten.first  #or can do [0][0]
  end

  def self.create(hash)
    student = self.new(hash[:name], hash[:grade])
    student.save
    student  
  end

end
