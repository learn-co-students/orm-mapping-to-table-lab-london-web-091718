require "pry"

class Student
attr_accessor :name, :grade
attr_reader :id
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

def initialize(id = nil, name, grade)
@name = name
@grade = grade
@id = id
end

def self.create_table
  sql = <<-SQL
  create table students(id integer primary key, name text, grade text);
  SQL
  DB[:conn].execute(sql)

end

def self.drop_table
sql = <<-SQL
drop table students;
SQL
DB[:conn].execute(sql)
end

def save
  sql = <<-SQL
  insert into students (name,grade) values(?,?);
  SQL
  DB[:conn].execute(sql, self.name, self.grade)
  @id = DB[:conn].execute("SELECT MAX(ID) AS LastID FROM students")[0][0]
end

def self.create(name:, grade:)
student = Student.new(name, grade)
student.save
student
end


end
